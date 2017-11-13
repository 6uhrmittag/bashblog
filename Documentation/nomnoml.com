



[<actor>You] -> [<usecase> Wants to share a quick tip in the Termial]
[<actor>You] -> [<usecase> Found an Post on Reddit]
[<actor>You] -> [<usecase> Wants to share a Website]
[<actor>You] -> [<usecase> Wants to share a long Blogpost]
[<usecase> Wants to share a quick tip in the Termial] -> [<state> ssh to Webserver]
[<state> ssh to Webserver] ->  -> [<input> publish via Terminal]
[<usecase> Found an Post on Reddit] -> [<input> publish via Share-Button]
[<usecase> Wants to share a Website] -> [<input> publish via eMail Client]
[<usecase> Wants to share a long Blogpost] -> [<input> publish via eMail Client]

[<usecase> Write Blogpost] -> [<start>Start]
[<start>Start] -> [<choice> Input Post via]
[<choice> Input Post via] -> [<input> Terminal]
[<choice> Input Post via] -> [<input> E-Mail]

[Enggine|
  [Cylinder]->1[Piston]
  [Cylinder]->2[Valve]
]



[E-Mail|
  [Subject]->[$Text]
  [Body]->[$URL]
]


[Carj| valves: Valve\[\]
 valves: Valve
  valves: Valve\[\]
]
[Engifne|
  [Cylinder]->1[Piston]
  [Cylinder]->2[Valve]
]


[<package>vehicles|[Cjar]|[Cjar]|[Cjar]]


[Chtar]--[<note>only driven;twice a month]









#padding: 18
#spacing: 30
#fill: #eee8d5; #fdf6e3
#font: Calibri
#fontSize: 12
#leading: 1.
#lineWidth: 2
#title: Usecase_Bashblog

[<actor>You] -> [<usecase> Wants to share a quick tip in the Termial]
[<actor>You] -> [<usecase> Found Link in App]
[<actor>You] -> [<usecase> Found Website in Browser]
[<actor>You] -> [<usecase> Wants to publish a long Blogpost]

[<usecase> Wants to share a quick tip in the Termial] -> [<state> ssh to Webserver]
[<state> ssh to Webserver] -> [<input> publish via Terminal]
[<input> publish via Terminal] -> [Blog]

[<usecase> Found Link in App] -> [<state> push Share-Button]
[<state> push Share-Button] -> [E-Mail(link)]
[<usecase> Found Website in Browser] -> [<state> publish via eMail Client]
[<input> publish via eMail Client] -> [E-Mail(link)]
[<usecase> Wants to publish a long Blogpost] -> [<state> open E-Mail Client]
[<state> open E-Mail Client] -> [<input> write post in Markdown]
[<state> write post in Markdown] -> [E-Mail(post)]
[E-Mail(post)] -> [<sender> send E-Mail]
[E-Mail(link)] -> [<sender> send E-Mail]

[Blog |
  [Post]
  [Link]

]


[E-Mail(link)|
  [Subject]->[$Text]
  [Body]->[$URL]
]
[E-Mail(post)|
  [Subject]->[$Title]
  [Body]->[$Post]
]

[<sender>send E-Mail] -> [<receiver> E-Mail Inbox]
[<receiver> E-Mail Inbox] <:- [<state> Zappier]
[<state> Zappier] -> [<state> prase E-Mail]
[<state> prase E-Mail] -> [<state> Generate RSS-Feed]
[<state> Generate RSS-Feed] -> [<state> publish RSS-Feed]
[<state> publish RSS-Feed]->[RSS-Feed| Title| URL| Tag(s)| Date| E-Mail ID]
[RSS-Feed] <:- [<state> Download Feed]
[<state> Download Feed] <:- [<state>Cronjob]












#title: Bashblog_input


[<start>]->[<choice>Input]

[<choice>Input] -> [<input>E-Mail]
[<choice>Input] -> [<input>Terminal]
[<input>E-Mail] -->[Mail Import]
[<input>Terminal] -->[Manual Import]
[Mail Import|
  [Cronjob]-->[Mail.sh |Parse RSS Feed | beitraggenerieren.sh | generate_index.sh | publish post]
]
[Manual Import|
[input_entry.sh | Ask for Input | beitraggenerieren.sh | generate_index.sh | publish post]
]

[Mail Import] -> [<state> published]
[Manual Import] ->[<state> published]
[<state> published] -> [<end> post published]











#title: Bashblog_input


[<start>]->[<choice>Input]

[<choice>Input] -> [<input>E-Mail]
[<input>E-Mail] -> [<state>Send E-Mail]
[<choice>Input] -> [<input>Terminal]
[<input>Terminal]->[<state>SSH to Webserver]

[<state>Send E-Mail] ->[Mail Import]
[<state>SSH to Webserver] ->[Manual Import]




[Manual Import|
    [input_entry.sh|
    [<state>Ask for Input] -->[Output| Title | URL | Tag(s)]
        [Output] --> [<reference>beitraggenerieren.sh]
[<reference>beitraggenerieren.sh] -> [<reference>generate_index.sh]
      ]
]


[Mail Import|
    [Cronjob]-->[Mail.sh|
        [<state>Download Feed] -> [<state>Parse Feed]
        [<state>Parse Feed] -->[Output| Title | URL | E-Mail-ID]
        [Output] --> [<reference>beitraggenerieren.sh]
[<reference>beitraggenerieren.sh] -> [<reference>generate_index.sh]
      ]
]

[Mail Import] -> [<state> Post published]
[Manual Import] ->[<state> Post published]
[<state> Post published] -> [<end> post published]
