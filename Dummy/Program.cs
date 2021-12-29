using Dummy;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// Works
Ümlaute ümlaute = new();
// Does not work
Umlautä umlautä = new();

app.Run();
