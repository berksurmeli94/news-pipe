namespace backend.RequestModels;

public class FilterRequestModel
{
    public int Skip { get; set; }
    public int Take { get; set; } = 15;
    public string SearchTerm { get; set; } = string.Empty;

}