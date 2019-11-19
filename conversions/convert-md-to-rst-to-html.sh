# file: convert-to-rst.sh


# A script for the bash shell to read all the .md  markdown
# files from a specified directory and then convert them
# with Pandoc to restructured text with a new suffix .rst .
# Store the newly created .rst files into a directory
# named `source`.
# With sphinx convert the .rst files to .html into  the
# `build` directory.

# Put this script in a directory named `conversions`

# prerequisites packages
# * pandoc - https://pandoc.org/installing.html
# * sphinx - http://www.sphinx-doc.org/en/master/index.html
# * python3 virtual environment named `venv` to be available.

# edit these paths for your project
myHome=~
#fromDirectory=$myHome'/Documents/2019/coding_projects/PrISM/app/content/'
#toDirectory=$myHome'/Documents/2019/coding_projects/PrISM/readthedocs/source/'
#toDirectory=$myHome'/Documents/2019/coding_projects/tempDeleteMe/source/'
#toDirectory=$myHome'/Documents/2019/coding_projects/conversions/source/'
fromDirectory=$myHome'/Documents/2019/coding_projects/PrISM-read-the-docs/content/'
toDirectory=$myHome'/Documents/2019/coding_projects/PrISM-read-the-docs/conversions/source/'
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# edit nothing below this line
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
clear
# Expecting an already installed python3 virtual environment
#source /path/to/ENV/bin/activate
if [[ "$VIRTUAL_ENV" == "" ]]
then
    source ./venv/bin/activate
    echo -e "Activated the VIRTUAL_ENV \n"$VIRTUAL_ENV
else
    echo -e "The active VIRTUAL_ENV is \n"$VIRTUAL_ENV
fi
# prerequisites packages
# * pandoc - https://pandoc.org/installing.html
# * sphinx - http://www.sphinx-doc.org/en/master/index.html
echo -e "\nAre the prerequisites installed?"
echo -e "- - - - - - - - - - - - - - - - - - - - - - \n"
pandoc --version || exit 1
echo -e "\n- - - - - - - - - - - - - - - - - - - - - - \n"
sphinx-build --version || exit 1
echo -e "\n- - - - - - - - - - - - - - - - - - - - - - \n"


echo "Checking to see if sphinx-quickstart has been run..."
[ -f Makefile ] && echo "  Makefile installed" || echo "  Makefile not installed"
[ -f ./source/conf.py ] && echo "  ./source/conf.py installed" || echo "  ./source/conf.py not installed"

if [ ! -f Makefile ] && [ ! -f ./source/conf.py ]; then
        echo -e "\n- - - - - - - - - - - - - - - - - - - - - - \n"
        echo "Running sphinx-quickstart"
        sphinx-quickstart;
       echo -e "\n- - - - - - - - - - - - - - - - - - - - - - \n"
fi

# if the toDirectory  does not exist then create it
if [ ! -d "$toDirectory" ]; then
    echo -e "\nCreating new directory \n"$toDirectory "\n"
    mkdir $toDirectory
else
   echo -e "\nPreparing to overwrite existing contents of \n"$toDirectory "\n"
fi



for file in $fromDirectory/*; do
    convertMeFrom="$(basename "$file")"
    printf "\n - - - - - \n"
    echo "convertMeFrom: " $convertMeFrom
    convertMeTo=${convertMeFrom%.md}      # Strip ".md" suffix off filename
    convertMeTo=$convertMeTo".rst"        # add suffix ".rst"
    echo -e "convertMeTo: "$convertMeTo

    source=$fromDirectory$convertMeFrom
    target=$toDirectory$convertMeTo
    #echo 'source: '$source
    #echo 'target: '$target
    #reference
    # https://pandoc.org/demos.html
    #  Example  number 6
    # $ pandoc -s -t rst --toc MANUAL.txt -o example6.text
    pandoc -s -t rst --toc $source  -o $target
done


echo -e "\n- - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n"
echo "With Sphinx, convert .rst files to .html"
echo "Reference documentation:"
echo "http://www.sphinx-doc.org/en/master/usage/quickstart.html"
echo -e "\n- - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n"

echo "The file './source/index.rst' is expected to have the documents listed in"
echo "the expected order of conversion.  The editing is done manually by (you)"
echo "the document owner according to instructions at:"
echo "  http://www.sphinx-doc.org/en/master/usage/quickstart.html#defining-document-structure"
echo "  and"
echo "  http://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-toctree"
echo -e "\n- - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n"

echo -e "Has the document './source/index.rst' been edited to the owners satisfaction?[y/n/q]"

# process the users answer
do_exit=0
while [[ $do_exit == 0 ]]; do
    #echo
    read -s -n1 satisfied

    case $satisfied in
        'y' )
            # Command line syntax generic
            # $ sphinx-build -b html sourcedir builddir
            sphinx-build -b html source build

            echo "Opening the index.html page in the firefox browser"
            echo "Check your browser for a new tab with PrISM in it."
            firefox ./build/index.html
            break
            ;;
        'n' )
            echo "Continue editing. Are you are ready[y,n,q]"
            ;;
        'q' )
            do_exit=1
            ;;
        *)
            echo 'Invalid selection'
            ;;
    esac
done # end process the users answer

echo "Aba, aba, aba, daba, that's all folks!"
