namespace backend_dotnet8.Core.Dtos.General
{
    public class GeneralServiceResponseDto
    {
        public bool IsSuccess { get; set; } = false;
        public int StatusCode { get; set; } = 400;
        public string Message{ get; set; } = "Error Occurred";
    }
}
