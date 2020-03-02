
public class StateException extends RuntimeException {
	public StateException(int id) {
		if (id == 1) {
			System.out.println("Every commit should have a preceding start.");

		} else if (id == 2) {
			System.out.println("Every start should have a commit.");

		} else if (id == 3) {
			System.out.println("Start followed by immediate start is an error.");

		} else if (id == 4) {
			System.out.println("Commit followed by immediate commit is also an error.");

		} else if (id == 5) {
			System.out.println("Modify can only happen between start and commit.");

		}
		else if (id == 6) {
			System.out.println("Every rollback should have a preceding start.");

		}
		else if (id == 7) {
			System.out.println("Nothing to rollback.");

		}
		else if (id == 8) {
			System.out.println("Rollback followed by immediate rollback is an error.");

		}

	}
}