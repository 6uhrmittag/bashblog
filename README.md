# bashblog

Blog system based on shell scripting. Input via shell or email.
mainly for privat and learning purposes.


## Getting Started

These instructions will guide you though installing your own blog. It is at a vry young age, so please expect undocumented parts.

### Prerequisites

Software needed
- xmlstarlet
```sudo apt-get install xmlstarlet```
- sed
```usually installed```
- xml_grep ```included in xml-coreutils```

### Installing

There is no routine to install the blog, yet. Copy the branch ```master``` to your webserver. It doesn't need to be in the webserver's folder. ```~/bin/```could be a possible path. You need to be able to execute the scripts - ```chmod``` them to your needs.
Copy ```config/config_template.conf``` to ```config/config.conf``` and change the two first lines to your need. ```install_path``` is the current path. ```html_path``` is the root directory for the final website. It must be accessible via web. You probably have do ```mkdir``` the needed folders yourself. Maybe even ```touch``` some files to create them initially. 

## Running the tests

There are no automated tests. Run ```blogeintrag.sh``` (for manually importing a new entry) or ```mail.sh``` (for importing via RSS) after changing the code. Both scripts run ```beitraggenerieren.sh``` and ```bloggenerieren.sh``` after importing new entries.
When testing ```mail.sh``` make sure you delete email IDs in ```ids.txt``` to use the same test-mails again.

The test succeeded when
1. the entry is imported in ```/html/entries/```,  
2. the entry is in ``ìndex.html```
3. all parts of the entry are as they should be (url clickable, text and tag are presend)

## Contributing

I have not yet thought about others contributing to the project. We'll figure it out as soon as someone is interested in contributing.

## Versioning

I use gitlab for versioning. See the code at [https://gitlab.com/6uhrmittag/bashblog](https://gitlab.com/6uhrmittag/bashblog).

## Authors

* **Marvin Heimbrodt** - *Initial work* - [6uhrmittag](6uhrmittag.de)
