graph LR


I1-->ti0
I2-->e2

Z1-->e2
e3-->Z6

subgraph Input
  I1[Terminal]
  I2[E-Mail]
end

subgraph E-Mail Import
  e2[Inbox]
  e3[Cronjob]
  e4[Output]
  eo1[Subject = $Title]
  eo2[Body = $URL]
  eo3[E-Mail ID = $ID]
  e3-->eo1
  e3-->eo2
  e3-->eo3
  eo1-->e4
  eo2-->e4
  eo3-->e4
end

subgraph Terminal Input
  ti0[blogentry.sh]
  tii0[Ask for Input]
  tii1[Text=$Text]
  tii2[URL=$URL]
  tii3["Tag(s)=$Tags"]
  tiO[Output]
  ti0-->tii0
  tii0-->tii1
  tii0-->tii2
  tii0-->tii3
  tii1-->tiO
  tii2-->tiO
  tii3-->tiO
end

subgraph Zappier
  Z1[Search inbox for E-Mail]
  Z2[Generate RSS Feed]
  Zo1[Subject = $Title]
  Zo2[Body = $URL]
  Zo3[E-Mail ID = $ID]
  Z5[Publish Feed]
  Z6[Feed URL]

  Z1-->Z2
  Z2-->Zo1
  Z2-->Zo2
  Z2-->Zo3
  Zo1-->Z5
  Zo2-->Z5
  Zo3-->Z5
  Z5-->Z6
end
