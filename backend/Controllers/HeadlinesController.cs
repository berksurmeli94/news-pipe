using backend.Models;
using backend.RequestModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend.Controllers;

public class HeadlineController : BaseController<HeadlineController>
{
    private readonly NewspipeContext context;
    public HeadlineController(NewspipeContext context)
    {
        this.context = context;
    }

    [HttpGet]
    public IActionResult Get([FromQuery] FilterRequestModel? filter)
    {
        var query = context.Headlines.Select(x => new Headline
        {
            Uid = x.Uid,
            Title = x.Title,
            Source = x.Source,
            Url = x.Url,
            PublishedAt = x.PublishedAt
        }).AsQueryable();

        if (filter != null)
        {
            if (!string.IsNullOrEmpty(filter.SearchTerm))
            {
                query = context.Headlines
                    .FromSqlInterpolated($@"
                    SELECT * FROM ""Articles""
                    WHERE ""Title"" ILIKE {'%' + filter.SearchTerm + '%'}
                    OR metadata->>'summary' ILIKE {'%' + filter.SearchTerm + '%'}
                    OR EXISTS (
                        SELECT 1 FROM jsonb_array_elements_text(metadata->'keywords') AS kw
                        WHERE kw ILIKE {'%' + filter.SearchTerm + '%'}
                    )
                ");
            }
            query = query.Skip(filter.Skip).Take(filter.Take);
        }

        return Ok(query.AsNoTracking().ToList());
    }
}