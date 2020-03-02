import java.util.*;

public aspect TransactionVerifier {
	HashMap<Transaction, Integer> state = new HashMap<Transaction, Integer>();
	ArrayList<Transaction> rollbacks = new ArrayList<Transaction>();
	HashMap<Transaction, ArrayList<Integer>> modifications = new HashMap<Transaction,ArrayList<Integer>>();
	before(Transaction t):
		call(* Transaction.start()) && target(t)
		{
		if (state.containsKey(t)) {
			int val = state.get(t);
			if (val != 0) 
			{
				if (val == 1) {
					state.remove(t);
					throw new StateException(3);
					
				}
				if (val == 2) {
					state.remove(t);
					throw new StateException(2);
				}
			}
			else {
				state.put(t, 1);
			}

		} 
		else {
			
			state.put(t, 1);
		}
	}
	before(Transaction t):
		call(* Transaction.modify()) && target(t)
		{
		if(rollbacks.contains(t)) {
			rollbacks.remove(t);
		}
		if(!modifications.containsKey(t)) {
			modifications.put(t, new ArrayList<Integer>());
		}
		int length = modifications.get(t).size();
		modifications.get(t).add(length+1);
		if (state.containsKey(t)) 
		{
			int val = state.get(t);
			if (val == 0) {
				state.remove(t);
				throw new StateException(5);
			}
			else if(val==1 || val ==2) {
				state.put(t, 2);
			}
		} 
		else {
			state.remove(t);
			throw new StateException(5);
		}
	}
//	Object around(Transaction t):
	before(Transaction t):
		call(* Transaction.rollback()) && target(t)
		{
		if (state.containsKey(t)) 
		{
			int val = state.get(t);
			if (val == 0) {
				state.remove(t);
				throw new StateException(6);
			}
			else if(val==1) {
				if(rollbacks.contains(t)) {
					state.remove(t);
					throw new StateException(8);
				}
				else {
					state.remove(t);
					throw new StateException(7);
				}
			}
			else if(val==2) {
				rollbacks.add(t);
				ArrayList<Integer> entry = modifications.get(t);
				for(int i=entry.size()-1;i>=0;--i) {
					System.out.println("Redoing Modification number " + entry.get(i));
				}
				modifications.remove(t);
//				for (Map.Entry<Transaction, ArrayList<Integer>> entry : modifications.entrySet()) {			
//					// If the server is running even after main method has returned, then it violates property 1.
//					for(int i=entry.getValue().size()-1;i>=0;--i) {
//						System.out.println("Redoing Modification number " + i);
//					}
//				}
				state.put(t, 1);
			}
		} 
		else {
			state.remove(t);
			throw new StateException(6);
		}
//		return proceed(t);
	}
	Object around(Transaction t) :
		call(* Transaction.commit()) && target(t)
		{
		if (state.containsKey(t)) 
		{
			int val = state.get(t);
			if (val == 0) {
				state.remove(t);
				throw new StateException(4);
			}
			else if(val==1) {
				state.put(t, 0);
			}
			else if(val ==2) {
				state.put(t, 0);
			}
		} 
		else {
			state.remove(t);
			throw new StateException(1);
		}
		return proceed(t);
	}
	
	after() :execution (public static void Testcase.main(String [])) {
		for (Map.Entry<Transaction, Integer> entry : state.entrySet()) {			
			// If the server is running even after main method has returned, then it violates property 1.
			if (entry.getValue()==1 ||entry.getValue()==2) {
				
				System.out.println("Transaction with Id:" +entry.getKey().getId() + " ended without commit");
//				state.remove(t);
				throw new StateException(2);
			}
		}
	}
	
	
	
	

//	after(Iterator i):
//		call(* Iterator.hasNext()) && target(i)
//		{
//
//	}
	
	
	
	
}
