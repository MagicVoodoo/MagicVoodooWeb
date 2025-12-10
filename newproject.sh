#!/bin/bash

PROJECT_NAME="MagicVoodooWeb"
DOTNET_VERSION="net10.0"

echo "Creating Blazor WebAssembly SPA project: $PROJECT_NAME"

# 1. Create the Blazor WebAssembly project (standalone)
dotnet new blazorwasm \
    -o $PROJECT_NAME \
    --framework $DOTNET_VERSION \
    --pwa true

cd $PROJECT_NAME

echo "Enabling Release optimizations for SPA..."

# 2. Update csproj to enable AOT + trimming + Brotli/Gzip publish options
cat << 'EOF' > $PROJECT_NAME.csproj
<Project Sdk="Microsoft.NET.Sdk.BlazorWebAssembly">

  <PropertyGroup>
    <TargetFramework>net10.0</TargetFramework>
    <InvariantGlobalization>true</InvariantGlobalization>

    <!-- SPA Optimization -->
    <BlazorEnableTimeZoneSupport>false</BlazorEnableTimeZoneSupport>
    <PublishTrimmed>true</PublishTrimmed>
    <PublishAot>true</PublishAot>

    <!-- Reduce output size -->
    <DebuggerSupport>false</DebuggerSupport>
    <UseSystemTextJson>true</UseSystemTextJson>

    <!-- Enable service worker install for PWA -->
    <ServiceWorkerAssetsManifest>service-worker-assets.js</ServiceWorkerAssetsManifest>

    <!-- Enables pre-compressed static assets -->
    <BlazorCacheBootResources>true</BlazorCacheBootResources>
    <BlazorEnableCompression>true</BlazorEnableCompression>

    <AssemblyName>MagicVoodooWeb</AssemblyName>
    <RootNamespace>MagicVoodooWeb</RootNamespace>
  </PropertyGroup>

</Project>
EOF

echo "SPA configuration applied."

# 3. Add a minimal index.html optimization (removes autoflush, adds `modulepreload`)
cat << 'EOF' > wwwroot/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link href="css/app.css" rel="stylesheet" />
    <base href="/" />

    <link rel="manifest" href="manifest.json">
    <meta name="theme-color" content="black">

    <script type="modulepreload" href="_framework/blazor.webassembly.js"></script>

    <title>Magic Voodoo</title>
</head>
<body>
    <div id="app">Loading...</div>
    <script src="_framework/blazor.webassembly.js" autostart="true"></script>
</body>
</html>
EOF

echo "Optimized index.html generated."

# 4. Publish command reminder
echo "To publish your optimized SPA:"
echo "  dotnet publish -c Release --no-build"
