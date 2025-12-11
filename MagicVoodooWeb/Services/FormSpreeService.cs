using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;
using MagicVoodooWeb.Models;

namespace MagicVoodooWeb.Services;

public class FormSpreeService
{
    private readonly IHttpClientFactory _httpClientFactory;

    public FormSpreeService(IHttpClientFactory httpClientFactory)
    {
        _httpClientFactory = httpClientFactory; // injecting the factory
    }

    public async Task SendEmail(FormMessage message)
    {
        var client = _httpClientFactory.CreateClient();
        client.DefaultRequestHeaders.Add("Accept", "application/json");

        var data = new[]
        {
            new KeyValuePair<string, string>("email", message.Email),
            new KeyValuePair<string, string>("name", message.Name),
            new KeyValuePair<string, string>("message", message.Message)
        };
        var content = new FormUrlEncodedContent(data);
        
        var response = await client.PostAsync("https://formspree.io/f/mvgewygv", content);
        if (!response.IsSuccessStatusCode)
        {
            Console.WriteLine(await response.Content.ReadAsStringAsync()); 
            var responceObject = await JsonSerializer.DeserializeAsync<dynamic>(await response.Content.ReadAsStreamAsync());
            throw new Exception("Something went wrong");
        }
    }
}
