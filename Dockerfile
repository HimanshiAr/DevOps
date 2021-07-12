#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

# Stage 1
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /build
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app

# Stage 2
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS final
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "SampleDotNet3WebApp.dll"]



#FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
#WORKDIR /app
#EXPOSE 80
#EXPOSE 443
#
#FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
#WORKDIR /src
#COPY ["SampleDotNet5WebApp/SampleDotNet5WebApp.csproj", "SampleDotNet5WebApp/"]
#RUN dotnet restore "SampleDotNet5WebApp/SampleDotNet5WebApp.csproj"
#COPY . .
#WORKDIR "/src/SampleDotNet5WebApp"
#RUN dotnet build "SampleDotNet5WebApp.csproj" -c Release -o /app/build
#
#FROM build AS publish
#RUN dotnet publish "SampleDotNet5WebApp.csproj" -c Release -o /app/publish
#
#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "SampleDotNet5WebApp.dll"]