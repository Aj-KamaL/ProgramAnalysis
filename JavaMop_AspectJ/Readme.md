															Raj Kamal Yadav 2016076 Prateek Jain 2016068
							Assumption I: The regex matching is with the first n Transaction calls(methods). The very firt match will trigger the exception and the violation will be captured.


							Assumption II: The | symbol means union of regex.

							Assumption III: Rollback without any Modification is handled as an Exception in our case.

							Assumption IV: Properties like "Every start should have a commit." or "Transaction, once started, has to be completed (start again in case of rollback)(Nothing to roll back is included)." is compared afterr the execution of the Testcase.main and not while its execution.

Property 1: Every commit should have a preceding start.
		  commit

Property 2: Every start should have a commit.
		  (start modify* commit)* start modify* | (start modify* commit)* start modify modify* start
		  Explanation : There are two types of posiiblities for the above violations:
		  				a) Valid Transaction but not commmited by the user which will be caught when main is terminated.
		  				b) When an already stared transaction is restarted.


Property 3: Start followed by immediate start is an error.
		   (start modify* commit)* start start

Propeerty 4: Commit followed by immediate commit is also an error.
		   (start modify* commit) (start modify* commit)* commit


Property 5: Modify can only happen between start and commit.
		   (start modify* commit)* modify



________________________________________________________________________________________________________________________________________________

If the followinfg regex: (start modify* commit)* is matched than the transaction is valid. If not then one of the above mentioned regex will catch the appropriate violation.

________________________________________________________________________________________________________________________________________________


Transactions with Rollback:



Property 1: Every commit should have a preceding start.
		  commit

Property 2: Every start should have a commit.
		  (start (modify modify* rollback)* modify* commit)* start modify* | (start (modify modify* rollback)* modify* commit)* start modify modify* start


Property 3: Start followed by immediate start is an error.
		   (start (modify modify* rollback)* modify* commit)* start start

Propeerty 4: Commit followed by immediate commit is also an error.
		   (start (modify modify* rollback)* modify* commit) (start (modify modify* rollback)* modify* commit)* commit


Property 5: Modify can only happen between start and commit.
		   (start (modify modify* rollback)* modify* commit)* modify


Property 6: Transaction, once started, has to be completed (start again in case of rollback)(Nothing to roll back is included).
			Regex in Property 2 | (start (modify modify* rollback)* modify* commit)* start modify* rollback


Property 7: Every rollback should have a preceding start.
			(start (modify modify* rollback)* modify* commit)* rollback

Property 8: Rollback followed by immediate rollback is also an error.

			(start (modify modify* rollback)* modify* commit)* rollback rollback



________________________________________________________________________________________________________________________________________________

If the followinfg regex: (start (modify modify* rollback)* modify* commit)* is matched than the transaction is valid. If not then one of the above mentioned regex will catch the appropriate violation.

________________________________________________________________________________________________________________________________________________

