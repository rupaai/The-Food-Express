# The-Food-Express
Implementation of an online food ordering system using Distributed Database.
## Framework:
* PL-SQL
## Features:
* Food ordering system.
* Menu selection.
* Searching Based on food types.
* Ratng system
* Top restaurant List.
* User login system, verification system.
* Comment system on the ordered food item.
* **Machine learning** technique for restaurant suggestion based on ranking, age of restaurant  establishment

## Theory Implementation: _See 'Rules mentioned' directory_
* _Effect of Update._ If a site is updated, others relating to this site getss changed automaitically.
* _Query Simplification._ If I follow criterions of distributed database system, I can simplify any query we want so that it will take less space. We tried to implement it on our project.
* _Canonical Form._ Fragmentation queries are required to ’Union’ if they have to be reconstructed to global queries. This union form is called canonical form.
* _Qualified Relation Proof._ In my implementation, I tried to implement a query which has two qualified relations. The query was in form of [[[r1 : pr1]UN[r2 : qr2]JNF [[s1 : rs1]UN[s2 : ts2]]] which is later converted to [(r1UNr2)JNF (s1UNs2) : (porq)and(rort)andF ].
* _Database Profile Estimator._ Database profile holds the numeral information of the relations. I estimated the total bits each relation has.
* _Semmi Join Program._ We know that, a semi join program on join program can reduce the transmission cost of an application as it needs less bits to transmit.
* _Machine Learning Implementation._ Machine learning is a system by which can predict upcoming results. I used Multi − V ariateLinearRegression in our project to predict the quality of any restaurant based on price, the time from the restaurant is established and user rating. We know that only user rating can never be enough to judge a restaurant. So we tried to judge the quality of a restaurant based on these features.

