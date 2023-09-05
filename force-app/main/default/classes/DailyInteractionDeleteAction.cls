public class DailyInteractionDeleteAction implements Schedulable {
    public void execute(SchedulableContext ctx) {
        DeleteOldInteractions doi = new DeleteOldInteractions();
        Id batchId = Database.executeBatch(doi);
    }
}