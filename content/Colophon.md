# Colophon
How this site came to be developed and tested on

`$ uname -a`

`Linux 5.2.17-200.fc30.i686 #1 SMP Mon Sep 23 13:43:18 UTC 2019 i686 i686 i386 GNU/Linux`

## History
Original text content in [markdown](https://github.github.com/gfm/) format was copied from the [Prism app content](https://github.com/NorthwestGreenChemistry/PrISM/tree/develop/app/content) repository develop branch.  Images came from [PrISM app assets](https://github.com/NorthwestGreenChemistry/PrISM/tree/develop/app/assets) repository develop branch.

The original electron app was developed with the intent of publishing this content inside the app.  The app worked great, however required an annual fee for authentication and required end users to install a special app on their computers.

This document is the tutorial content liberated from the app.

## Multi-step process
Converting multiple markdown pages into an organized website.

* `markdown -> Pandoc -> reStructuredText -> Sphinx -> html -> Github -> read-the-docs`

## Pandoc
* Converting from markdown to reStructuredText requires the [installation](https://pandoc.org/installing.html#linux) and running of [Pandoc](https://pandoc.org/index.html).
* Command line syntax generic
  * `pandoc -s -t rst --toc $source  -o $target` where:
     * `$source=~/workspace/PrISM-read-the-docs/content`
     * `$target=~/workspace/PrISM-read-the-docs/conversions/source`
     * Pandoc copies from .md `/content` and converts into .rst `/source`
  
## reStructured Text

* [reStructuredText](http://docutils.sourceforge.net/rst.html) has an .rst suffix.
  * Pandoc outputs the .rst files to:

     `~/workspace/PrISM-read-the-docs/conversions/source`
   
* Currently the `/conversion/source/*.rst` files are the result of a scripted conversion from the markdown and should not be edited directly.

## Conversion to html

* Conversion to **html** requires the installation and running of [Sphinx](http://www.sphinx-doc.org/en/master/index.html) a python based document generator.
  * Change into the `/conversions` directory, which also has (or will have) the Makefile.
  
     `$ cd ~/workspace/PrISM-read-the-docs/conversions/`

  * **One time only**, to generate some sphinx defaults

      `$ sphinx-quickstart`
    
  * Command line syntax generic:

     `$ sphinx-build -b html source build` 
     
  * Command line syntax **specific to this project**:

     `$ sphinx-build -b html \`

     `~/workspace/PrISM-read-the-docs/conversions/source \`

     ` ~/workspace/PrISM-read-the-docs/conversions/build`
  
  * Sphinx expects an `index.rst` file that dictates the table of contents.  In this project the index did not exist previously, and was therefor created in the `/source` directory, and outlined in a way that seemed to mimic the numbering of the original markdown documents.

* The transformed output _build_ documents are served as a web page something like:

    `$ firefox ~/workspace/PrISM-read-the-docs/conversions/build/index.html`

## Workspace customization

1. [Install](https://pandoc.org/installing.html#linux) Pandoc. On [Fedora](https://apps.fedoraproject.org/packages/pandoc) linux it might look something like:
   
    `$ sudo dnf install pandoc`

2. Install python [virtual environment](https://pypi.org/project/virtualenv/) something like:

   `$ pip3 install virtualenv`

3. Create a virtual environment for the project

   `$ cd ~/workspace/PrISM-read-the-docs/conversions/`
   
   `$ virtualenv venv`
   
4. Enable the python virtual environment

   `$ cd ~/workspace/PrISM-read-the-docs/conversions/`
   
   `$ source ./venv/bin/activate`

5. Install [Sphinx](http://www.sphinx-doc.org/en/master/index.html)

   `$ cd ~/workspace/PrISM-read-the-docs/conversions/`
   
   `$ pip3 install -U sphinx`
   
## Github

* This documentation can be accessed at github.com/NorthwestGreenChemistry/[PrISM-read-the-docs](https://github.com/NorthwestGreenChemistry/PrISM-read-the-docs) something like:

    `$ git clone https://github.com/NorthwestGreenChemistry/PrISM-read-the-docs.git`

    * and once the edits are done push back to the repository

      `$ git remote add origin`

                `https://github.com/NorthwestGreenChemistry/PrISM-read-the-docs.git `

     `$ git push -u origin develop`

## Read-the-docs

> "[Read the Docs](http://readthedocs.org/) simplifies software
> documentation by automating building, versioning, and hosting of
> your docs for you. Think of it as Continuous Documentation."

1. Write the recommended `readthedocs.yml` [configuration](https://docs.readthedocs.io/en/stable/config-file/index.html#configuration-file) file into the root directory of the project. For example 

    `$ touch ~/workspace/PrISM-read-the-docs/readthedocs.yml`
    
2. `$ git push` the repository to Github.

3. [Sign in](https://readthedocs.org/accounts/login/) to the read-the-docs account to administer the configuration.

4. View the resulting documentation at [prism.readthedocs.io](https://prism.readthedocs.io)


## Misc important stuff

* The original links paths to assets such as images were hard coded in the app where the   In this document the hard coding have been deleted and replaced with relative paths.  This means the location of the asset directory matters relative to `/source`.  The assets directory was manually **copied** once into `/source` to allow Sphinx to easily find the assets.

     ```
     /conversions
                |- /source/
                          assets
                          (content .rst files)
                |- /build
     ```
     
* In order for the github repository to accurately render the markdown pages with images the `/assets` directory must be **moved** into the `/content` directory.

     ```
     /content
            |- /assets
     /conversions
     ```

* Markdown is great for simple docs, however reStructuredText meets the challenges of more complex documents, including features like table of contents and indexing.  If this Sphinx document format is marketable, it may make sense in a future revision to move away from markdown to only use the reStructuredText.


## Bash script for editing automation

There is a bash script written just for this project to allow the conversion process to be repeated during editing of the markdown files.

script

* location: `$ cd ~/workspace/PrISM-read-the-docs/conversions/`

* filename: `convert-md-to-rst-to-html.sh`

running the script

* Make the script executable
  * `$ chmod 744 convert-md-to-rst-to-html.sh`

* make some edits to the markdown in `/content`
* run the script in `/conversions` like this:
  * `$ ./convert-md-to-rst-to-html.sh`

