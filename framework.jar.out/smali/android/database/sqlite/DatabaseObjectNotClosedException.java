package android.database.sqlite;

public class DatabaseObjectNotClosedException extends RuntimeException {
    private static final String f4s = "Application did not close the cursor or database object that was opened here";

    public DatabaseObjectNotClosedException() {
        super(f4s);
    }
}
