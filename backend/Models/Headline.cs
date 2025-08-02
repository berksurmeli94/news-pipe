using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class Headline
{
    public long Uid { get; set; }

    public string Title { get; set; } = null!;

    public string Url { get; set; } = null!;

    public string Source { get; set; } = null!;

    public DateTime PublishedAt { get; set; }

    public string Metadata { get; set; } = null!;
    
    // {:summary=>
    //     "\"6 Weeks of Claude Code\" is a blog post that narrates the author's journey through six weeks of learning Claude Code, a programming language. The author shares their personal experiences, challenges, and insights gained throughout this process.",
    //     :keywords=>["Claude Code", "Programming Language", "Learning Journey", "Personal Experience", "Challenges"],
    //     :sentiment=>"Neutral"}

    public DateTime CreatedAt { get; set; }

    public DateTime UpdatedAt { get; set; }
}
