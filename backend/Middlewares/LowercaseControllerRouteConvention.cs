using Microsoft.AspNetCore.Mvc.ApplicationModels;

public class LowercaseControllerRouteConvention : IApplicationModelConvention
{
    public void Apply(ApplicationModel model)
    {
        foreach (var controller in model.Controllers)
        {
            var controllerName = controller.ControllerName.ToLower();

            foreach (var selector in controller.Selectors)
            {
                if (selector.AttributeRouteModel != null)
                {
                    selector.AttributeRouteModel.Template =
                        selector.AttributeRouteModel.Template.Replace("[controller]", controllerName);
                }
            }
        }
    }
}