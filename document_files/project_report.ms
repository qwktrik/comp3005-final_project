.de qhm
.\" Usage: .hm [alignment] [font size] heading text
.if \\$1 .nr SHalign \\$1
.if \\$2 .nr SHsize \\$2
.if !\\n[SHalign] .nr SHalign 1
.if !\\n[SHsize] .nr SHsize 12
\\fB\\s[\\n[SHsize]]
.if \\n[SHalign]==1 .ce
.if \\n[SHalign]==2 .lj
.if \\n[SHalign]==3 .rj
..

.de hsp
.if \\$1 .nr space \\$1
.if !\\n[space] .nr space 1
.sp \\n[space]
..

.de bullet
.IP \(bu 2
..

.de bbullet
.IP \(bu 2
.ft B
..

.de b1
.B1
.sp 0.2
.ft CW
.nf
..

.de b2
.fi
.sp 0.2
.B2
.ft
..

.EQ
delim $$
.EN

.ds CH
.ds CF - % -

.TL
\s[14]
Health and Fitness Club Management Database
.AU
Quentin Wolkensperg [101157870]
.AI
COMP 3005 Fall 2023


.SH
.qhm
Design
.hsp
.QP
This section will go over the design intentions of the database as well as covering some basic assumptions from table to table.
.SH
General Design
.LP
The basic design of this model is sort of 'Member' focused. The member table is the main sort of entity that will be interfacing with the rest of the tables and has three main attributes to consider.
.bullet
Member type. Are they a trainer or an admin.
.bullet
Member attributes. From user entered info to calculated stats as well as transactions committed. These are things that can been seen as defining a particular member and are member specific values.
.bullet
Bookings. This just holds what training sessions and group events specific members are a part of and can be seen as their schedule.
.SH
Member Type Tables
.LP
.BX "Member"
.QP
Keeps track of username and unique member ID. As well as health metrics for this example case it is just simple stuff like height and weight.
.LP
.BX "Trainer"
.QP
This table just defines that the member is actually a trainer. Trainers also have different relationships to group events and training sessions and are treated differently in those tables to regular members.
.LP
.BX "Admin"
.QP
Really just to separate out admin users to the rest of the program. More on why this exists in assumptions.
.SH
Member Attributes
.LP
.BX "Transactions"
.QP
This database holds members and their transactions. This is to keep track of member spending as well as to apply loyalty points. This was separated out to abstract from the booking side of things to make thing more logical when working on a front-end. Transactions also have a sub table
.BX Service
that defines a service name (what a member is paying for) the base cost and the amount of loyalty points awarded for purchasing that service. A very simple implementation of a transaction service as there is not even a transaction number, who made the transaction, what was the type and at what time is what defines the transaction.
.LP
.BX "Loyalty Points"
.QP
Defines how much loyalty points a given user has.
.LP
.BX "Achievement"
.QP
Assumed managed by staff members. I.e staff members define achievements in which the members can strive to complete. Keeps track of what achievements there are to complete. Members can also "complete" these achievements.
.LP
.BX "Routine"
.QP
Assumed members make their own fitness routines. Keeps track of fitness routines and their steps as well as calories burned.
.LP
.BX "Fitness Goal"
.QP
Assumed members create these goals for themselves. Keeps track of members goals and status of these goals (complete or not).
.SH
Bookings
.LP
.BX "Group Event"
.QP
Keeps track of group events and their attributes. Can be managed by multiple trainers and can be attended by multiple members. Is located in a one
.BX "Room"
Also it keeps track of a cost as it is assumed these group events are sort of unique and not super regular.
.LP
.BX "Training Session"
.QP
Each training session only has one trainer and one member and can be located in one
.BX Room
There can be multiple sessions with the same member and trainer so date is also used as a unique key. Keeps track of personal training sessions past, present and future.
.SH
Other/Inventory
.LP
.BX Room
.QP
Keeps track of the rooms owned by the club.
.LP
.BX Item
.QP
Keeps track of items owned by the club. Treated as if they are stored in rooms.
.LP
.BX "Points Rate"
.QP
Keeps track of what amount of points give what discounts. Can be used with transactions. It is why
.BX Service
holds a base cost and the
.BX Transaction
holds the actual cost paid. In this system money can be refunded easily but some calculations would have to be done to refund loyalty points.

.SH
.qhm
Assumptions
.hsp
.QP
In this section I will discuss specific assumptions made about the database, why they were made and the influence on the design.
.SH
Date Conflicts
.LP
Date conflicts in scheduling are assumed to be handled either by triggers or the program itself. This was specifically chosen because the way conflicts could be defined could change over time for example a person can be in two group events at once but personal training sessions can't overlap. This is why it makes sense for this problem to be handled with code instead of in the database structure. Also such a format would likely be neigh impossible from my experience. Date fields and duration's have been added to help a programmatic solution get values for specific scheduled activities.
.SH
Transactions
.LP
Transactions are assumed to take place sort of separately to actual bookings. It would be up to the front-end to prompt for transactions before allowing bookings. This led to a transaction table.
.SH
Permissions
.LP
Handling who can do what will have to be handled by the program. This specifically refers to blocking normal members our of what trainers can do and what admins can do. I did add admin and trainer tables to separate out these members but permissions to what commands will have to be handled by the program.
.SH
Metrics And Statistics
.LP
I'm assuming for this project that the metrics will be stored more on members as attributes. Statistics will be reached from other tables and calculated by the front-end and displayed on the dashboard.
.LP
Note: A better way to allow for more expressive user defined metrics and statistics would probably be better handled by a NoSQL database.

.SH
.qhm
ER Model
.hsp
.PDFPIC "ERFitness.pdf"
.LP
.ce
.SM
.pdfhref W -D https:example.com "Link to ER Model"

.SH
.qhm
Database Structure (Version 1)
.hsp
.QP
I decided to take 8 tables from the ER model and convert them to a relational database schema.
.RS
.bullet
Member
.bullet
Trainer
.bullet
Training Session
.bullet
Group Event
.bullet
Transaction
.bullet
Service
.bullet
Fitness Goal
.bullet
Achievement
.RE
.QP
This is because I will get some extra tables from many to many relationships and I think this represents a basic overview of what I was trying to accomplish with the database. It represents the three aspects of a member, Member Type, Member Attributes and Member Bookings.

.PDFPIC "dbversion1.pdf"
.LP
.ce
.SM
.pdfhref W -D https:example.com "Link to DB Structure Ver 1"

.SH
.qhm
Normalization
.hsp
.QP
This section will explain the normalization process. I will be skipping many to many relationship tables in my analysis as they technically do not adhere to 3NF but are necessary to describe the relationships.
.LP
.B1
.SH
.BX "Member"
.SH
Functional Dependencies
.RS
.bullet
Member ID $->$ Username, Height, Weight
.RE
.SH
Second Normal Form
.LP
Already in second normal form. What differentiates each value from others is the Member ID.
.SH
Third Normal Form
.LP
Already in third normal form. Nothing is shared between keys (there is only one).
.sp
.B2

.LP
.B1
.SH
.BX "Trainer"
.SH
Functional Dependencies
.RS
.bullet
Trainer ID $->$ Member ID
.RE
.SH
Normalization
.LP
Already normalized this is just a very simple relation.
.sp
.B2

.LP
.B1
.SH
.BX "Group Event"
.SH
Functional Dependencies
.RS
.bullet
Group Event ID $->$ Name, Description, Event Type, Start Date, Duration, Cost
.RE
.SH
Normalization
.LP
Already in 2NF and 3NF as all non-prime elements directly dependent on the primary key (Group Event ID).
.sp
.B2

.LP
.B1
.SH
.BX "Training Session"
.SH
Functional Dependencies
.RS
.bullet
Trainer, Member, Start Date $->$ Notes, Duration
.RE
.SH
Normalization
.LP
Already in 2NF and 3NF as Notes and Duration directly depend on the composite primary key.
.sp
.B2

.LP
.B1
.SH
.BX "Transaction"
.SH
Functional Dependencies
.RS
.bullet
Member, Date, Service Type $->$ Amount Paid
.RE
.SH
Normalization
.LP
Already in 2NF and 3NF as Amount Paid directly depend on the composite primary key.
.sp
.B2

.LP
.B1
.SH
.BX "Service"
.SH
Functional Dependencies
.RS
.bullet
Name $->$ Points, Base Cost
.RE
.SH
Normalization
.LP
Already in 2NF and 3NF as Points and Base Cost directly depend on the service Name. This intuitively makes sense, each service will have its own base cost and amount of loyalty points given out. The name directly differentiates each entry from another.
.sp
.B2

.LP
.B1
.SH
.BX "Fitness Goal"
.SH
Functional Dependencies
.RS
.bullet
Member, Name $->$ Description, Complete
.RE
.SH
Normalization
.LP
Already in 2NF and 3NF as Description and Complete directly depend on the composite primary key.
.sp
.B2

.LP
.B1
.SH
.BX "Achievement"
.SH
Functional Dependencies
.RS
.bullet
Achievement ID $->$ Description
.RE
.SH
Normalization
.LP
Already in 2NF and 3NF as Description directly depend on Achievement ID.
.sp
.B2

.QP
It looks as if making a good ER model and carefully converting into a Relational Database Diagram gives you 2NF and 3NF for free without having to change anything. My conversion was very simple though as many things were taken out for simplicity from the ER model. But after going though this I would be fairly confident that no normalization issues would crop up even if I did the full conversion.

.SH
.qhm
Database Structure (Version 2)
.hsp
.QP
The diagram does not change. It is already in 2NF and 3NF.

.SH
.qhm
PostgreSQL Database Creation
.hsp
.QP
This section will go over the commands to create the database described by the relational database schema created.

.BD
.ft CW
.nf
.so ddlh.groff
.fi
.ft
.DE
.LP
.ce
.pdfhref W -D https://example.com "Link to File"

.SH
.qhm
Test SQL Commands
.hsp
.QP
In this section will go over populating the database and some other queries to test the database out. These selection statements will be inspired by ones we would possibly want if making a program.
.SH
Populating Database
.BD
.ft CW
.ps 8
.so dmlh.groff
.ft
.DE
.LP
.ce
.pdfhref W -D https://example.com "Link to File"

.SH
Select Statements
.LP
List all members
.b1
SELECT * FROM Member;
.b2
.LP
Members that have not participated in a group event
.b1
SELECT m.username FROM Member m
LEFT JOIN Participant p ON m.member_id = p.member_id
WHERE p.member_id IS NULL;
.b2
.LP
Get first members fitness goals
.b1
SELECT * FROM Fitness_Goal
WHERE member_id = 1;
.b2
.LP
Get member with ID 2 transactions after date
.b1
SELECT * FROM Transaction
WHERE member_id = 2
AND date > '2023-01-01'
ORDER BY date;
.b2
.LP
Show achievements and what members have completed them.
.b1
SELECT a.description AS achievement_description, m.username AS member_name
FROM Achievement a
JOIN Completed c ON a.achievement_id = c.achievement_id
JOIN Member m ON c.member_id = m.member_id;
.b2
.LP
List training sessions for Member ID 3
.b1
SELECT * FROM Training_Session WHERE member_id = 3;
.b2
.LP
List group events for Member ID 2
.b1
SELECT * FROM Group_Event
WHERE group_event_id IN (
    SELECT group_event_id FROM Participant WHERE member_id = 2
);
.b2
.ce
.pdfhref W -D https://example.com "Link to File"

.SH
Update Statements
.LP
Update member weight
.b1
UPDATE Member SET weight = 78.5 WHERE member_id = 3;
.b2
.LP
Update training sessions notes
.b1
UPDATE Training_Session
SET notes = 'Great session see you next week'
WHERE trainer_id = 1 AND member_id = 2;
.b2
.LP
Update fitness goal as complete
.b1
UPDATE Fitness_Goal
SET complete = TRUE
WHERE member_id = 4 AND name = 'Flexibility';
.b2
.ce
.pdfhref W -D https://example.com "Link to File"

.SH
.qhm
Conclusion
.hsp
.QP
I did not have the time to add any application to go with this initially I was just going to make an ncuses client because I thought that would be fun. There are also no triggers or any extra stuff. I decided just to focus on the design as that was the main focus of the assignment.
