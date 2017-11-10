# bashblog

Blog system based on shell scripting. Input via shell or email.
The focus of this blog is to collect links/urls with a short tought/text.

## Features
Entries are grouped by the date of generation/import. Each entry has 3 features
- URL
- title
- tag(s)

An entry consists of only one url/link. The text of this link is the title.

### Modules
It is possible to extend the features via modules (or translators)
Modules:
- ```translator_youtube``` This module translates youtube urls to embedded youtube videos. When this module is active all imported youtube urls are shown as embedded videos.

## Getting Started

These instructions will guide you though installing your own blog. It is at a vry young age, so please expect undocumented parts.

### Prerequisites

Software needed
- xmlstarlet

`sudo apt-get install xmlstarlet`
- sed

`usually installed`
- xml_grep, (included in xml-coreutils)

Please see: [http://xml-coreutils.sourceforge.net/] instructions will follow.

### Installing

There is no routine to install the blog, yet. Copy the branch ```master``` to your webserver. It doesn't need to be in the webserver's folder. ```~/bin/```could be a possible path. You need to be able to execute the scripts - ```chmod``` them to your needs.
Copy ```config/config_template.conf``` to ```config/config.conf``` and change the two first lines to your need. ```install_path``` is the current path. ```html_path``` is the root directory for the final website. It must be accessible via web. You probably have do ```mkdir``` the needed folders yourself. Maybe even ```touch``` some files to create them initially.


### Usage
#### Write entry via command line
To write an entry manually just run ```blogeintrag.sh```. The script asks for ```URL```, ```title```and tag(s). <enter> after each input. Please seperate tags with ```,```.
After confirming the script generates an new ```index.html```
#### Write entry via email
It is possible to import entries through RSS. E-Mail import is currently done by an external service like zappier - the service scrapes an known inbox and generates an RSS feed. This feed is scraped by ```mail.sh```and is generating entries out of the feed.
The usag is simple
- ```E-Mail subject``` = Entry title
- ```E-Mail body``` = Entry URL
- Tags are not supported yet

Zappier generates an ID per email. This ID is stored in ```config/ids.txt``` and checked in the import script. Entries are grouped by the date the script is triggered.
After import the script generates a new ```index.html``` itself.

#### Autoimport via cronjob
To autoimport entries via RSS just add mail.sh to your crontab.
The script output is logged to /temp/cronlog.txt. Better log will come later.

In Terminal: ```crontab -e```

Add line: ```*  *  * * * cd "ADD-INSTALL-PATH-HERE" && ./mail.sh >> ./temp/cronlog.txt```

This will run the import every minute. See e.g. [crontab.guru](https://crontab.guru) for different settings.

## Running tests

There are no automated tests. Run ```blogeintrag.sh``` (for manually importing a new entry) or ```mail.sh``` (for importing via RSS) after changing the code. Both scripts run ```beitraggenerieren.sh``` and ```bloggenerieren.sh``` after importing new entries.
When testing ```mail.sh``` make sure you delete email IDs in ```ids.txt``` to use the same test-mails again.

The test succeeded when
1. the entry is imported in ```/html/entries/```,  
2. the entry is in ``ìndex.html```
3. all parts of the entry are as they should be (url clickable, text and tag are presend)

## Contributing

I have not yet thought about others contributing to the project. We'll figure it out as soon as someone is interested in contributing.

## Versioning

See the code at [https://github.com/6uhrmittag/bashblog](https://github.com/6uhrmittag/bashblog).

## Authors

* **Marvin Heimbrodt** - *Initial work* - [6uhrmittag](6uhrmittag.de)
