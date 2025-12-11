using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace MagicVoodooWeb.Models;

public class FormMessage
{
    [Required]
    [EmailAddress]
    [JsonPropertyName("email")] 
    public string Email { get; set; }

    [Required]
    [JsonPropertyName("name")] 
    public string Name { get; set; }

    [Required]
    [JsonPropertyName("message")] 
    public string Message { get; set; }
}