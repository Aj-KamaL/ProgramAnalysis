public class Transaction {
	public final int id ;
	public Transaction(int id) {
		// TODO Auto-generated constructor stub
		this.id = id;
	}
	
	public void start() {
		System.out.println("Transaction started");
	}
	
	public void modify() {
		System.out.println("Transaction modified");
	}
	
	public void commit() {
		System.out.println("Transaction commited");
	}
	
	public void rollback() {
		System.out.println("Transaction rollbacked");
	}
	public int getId() {
		return this.id;
	}
}