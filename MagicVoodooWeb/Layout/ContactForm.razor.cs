using System;
using System.Threading.Tasks;
using MagicVoodooWeb.Services;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;

namespace MagicVoodooWeb.Layout;

public partial class ContactForm : ComponentBase{
    [Inject] public FormSpreeService FormSpreeService { get; set; }
    
    // BUSINESS LOGIC FOR SUBMISSION
    protected async Task Submit()
    {
        try
        {
            await FormSpreeService.SendEmail(Form);

            Submitted = true;
            Form = new();
        }
        catch (Exception e)
        {
            
        }
    }
}