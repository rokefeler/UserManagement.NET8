namespace backend_dotnet8.Core.Entities
{
    public class Message: BaseEntity<long>
    {
        public string SenderUserName { get; set; }
        public string ReceievrUserName { get; set; }
        public string Text { get; set; }
    }
}
