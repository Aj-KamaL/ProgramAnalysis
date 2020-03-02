import java.util.*;  

public class Testcase {    
	
	public static void main(String[] args) {
		Transaction t=new Transaction(1);
//		t.start();
//		t.modify();
//		t.modify();
//		t.start();
//		
//		t.rollback();
//		t.rollback();
//		t.commit();
		int[] testcase=new int[10];
		int[] gty= {0,1,2,1,1,1,1,1,2,0};
		for(int i=0;i<10;i++) {
			Random r = new Random(); 
			int h=r.nextInt((3 - 0) + 1) + 0;
//			try {
			if(gty[i]==0) {
				System.out.println("Start");
				t.start();
			}
			else if(gty[i]==1) {
				System.out.println("Modify");
				t.modify();
			}
			else if(gty[i]==2) {
				System.out.println("Rollback");
				t.rollback();
			}
			else {
				System.out.println("Commit");
				t.commit();					
			}
//			}
//			catch(StateException e){
//				e.printStackTrace();
//			}
		}
		
	}    
	
	
	
}  