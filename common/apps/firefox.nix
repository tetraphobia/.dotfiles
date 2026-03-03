{
  config,
  pkgs,
  inputs,
  ...
}:
let
  skipDashboard = pkgs.stdenv.mkDerivation {
    pname = "skip-dashboard";
    version = "1.0";

    src = ./firefox/dashboard;
    nativeBuildInputs = [ pkgs.zip ];
    installPhase = ''
      mkdir -p $out
      cd $src
      zip -r $out/skip-dashboard.xpi *
    '';
  };
in
{
  # Configure firefox
  programs.firefox = {
    enable = true;

    # Needed for unsigned addons
    package = pkgs.firefox-nightly-bin;

    # Package dashboard addon
    policies = {
      ExtensionSettings = {
        "skip-dashboard@local" = {
          installation_mode = "force_installed";
          install_url = "file://${skipDashboard}/skip-dashboard.xpi";
        };
      };
    };

    profiles = {
      "temp" = {
        id = 1;
        isDefault = false;
      };
      "skip" = {
        id = 0;
        isDefault = true;

        settings = {
          "extensions.autoDisableScopes" = 0;

          # Some basic UI changes
          "sidebar.verticalTabs" = true;

          # Allow unsigned addons
          "xpinstall.signatures.required" = false;

          # Blank page on startup
          "browser.newtabpage.enabled" = true;
          "browser.startup.page" = 1;

          # Dark theme
          "ui.systemUsesDarkTheme" = 1;
          "browser.theme.dark-private-windows" = true;
          "layout.css.prefers-color-scheme.content-override" = 3;
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

          # Disable bookmarks toolbar
          "browser.toolbars.bookmarks.visibility" = "never";

          # Disable first launch welcome pages and UI tour
          "browser.startup.firstrunSkipsHomepage" = true;
          "browser.uitour.enabled" = false;
          "datareporting.policy.firstRunURL" = "";
          "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;

          # Improve rendering performance
          "gfx.canvas.accelerated.cache-size" = 256;
          "gfx.webrender.layer-compositor" = true;

          # Disable password suggestion and form fill
          "browser.formfill.enable" = false;

          # Disable telemetry
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "datareporting.usage.uploadEnabled" = false;

          # Disable DNS prefetching and speculative connections.
          "network.http.speculative-parallel-limit" = 0;
          "network.dns.disablePrefetch" = true;
          "network.dns.disablePrefetchFromHTTPS" = true;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.places.speculativeConnect.enabled" = false;
          "network.prefetch-next" = false;

          # Avoid caching to disk and limit session store interval
          "browser.cache.disk.enable" = false; # Keep cache in RAM only
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "media.memory_cache_max_size" = 65536;
          "browser.sessionstore.interval" = 60000; # Reduce session save frequency

          # Disable built-in password capture
          "signon.formlessCapture.enabled" = false;
          "signon.privateBrowsingCapture.enabled" = false;
          "network.auth.subresource-http-auth-allow" = 1;
          "editor.truncate_user_pastes" = false;

          # Trim cross-origin referer headers
          "network.http.referer.XOriginTrimmingPolicy" = 2;

          # Disable AI features
          "browser.ai.control.default" = "blocked";
          "browser.ml.enable" = false;
          "browser.ml.chat.enabled" = false;
          "browser.ml.chat.menu" = false;
          "browser.tabs.groups.smart.enabled" = false;
          "browser.ml.linkPreview.enabled" = false;

          # Enable stylesheets and compact mode
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.compactmode.show" = true;
          "browser.privateWindowSeparation.enabled" = false;

          # Disable recommendations, promotions, and nagging
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.preferences.moreFromMozilla" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.aboutwelcome.enabled" = false;
          "browser.profiles.enabled" = true;
        };

        userChrome = builtins.readFile ./firefox/userChrome.css;

        extensions = {
          force = true; # Override existing extension settings
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            # privacy-badger
            # ublock-origin
            # bitwarden
            # sponsorblock
            # multi-account-containers
          ];
          settings = {
            # Ublock settings
            # "uBlock0@raymondhill.net".settings = {
            #   selectedFilterLists = [
            #     "ublock-filters"
            #     "ublock-badware"
            #     "ublock-privacy"
            #     "ublock-unbreak"
            #     "ublock-quick-fixes"
            #   ];
            # };
          };
        };

        # Allow home-manager to overwrite search config
        search.force = true;
        search.engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "Nix Options" = {
            definedAliases = [ "@no" ];
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };
    };
  };
}
