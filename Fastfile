require "shellwords"

default_platform(:ios)

PROJECT_PATH = "Bassam Faraj (Founder & CExO).xcodeproj"
SCHEME_NAME = ENV.fetch("XCODE_SCHEME", "Phoenix Hovan")
DERIVED_DATA_PATH = ENV.fetch("DERIVED_DATA_PATH", "/tmp/keelport-derived-data")
SIMULATOR_NAME = ENV.fetch("SIMULATOR_NAME", "iPhone 17")

def xcode_destination
  value = ENV["XCODE_DESTINATION"].to_s.strip
  value.empty? ? "generic/platform=iOS Simulator" : value
end

def xcodebuild_command(action)
  [
    "xcodebuild",
    "-project", Shellwords.escape(PROJECT_PATH),
    "-scheme", Shellwords.escape(SCHEME_NAME),
    "-destination", Shellwords.escape(xcode_destination),
    "-derivedDataPath", Shellwords.escape(DERIVED_DATA_PATH),
    action
  ].join(" ")
end

def built_app_path
  pattern = File.join(DERIVED_DATA_PATH, "Build", "Products", "**", "*.app")
  Dir.glob(pattern).first
end

def booted_simulator_id
  devices = sh("xcrun simctl list devices booted", log: false)
  match = devices.match(/\(([A-F0-9-]{36})\) \(Booted\)/)
  match && match[1]
end

platform :ios do
  desc "Build Phoenix Hovan with an automatic destination fallback."
  lane :build_phoenix_hovan do
    sh(xcodebuild_command("build"))
  end

  desc "Build Keelport with an automatic destination fallback."
  lane :build_keelport do
    sh(xcodebuild_command("build"))
  end

  desc "Build Phoenix Hovan for a generic physical iOS device."
  lane :build_phoenix_hovan_device do
    ENV["XCODE_DESTINATION"] = "generic/platform=iOS"
    sh(xcodebuild_command("build"))
  end

  desc "Build Keelport for a generic physical iOS device."
  lane :build_keelport_device do
    ENV["XCODE_DESTINATION"] = "generic/platform=iOS"
    sh(xcodebuild_command("build"))
  end

  desc "Build, then install Phoenix Hovan when an app product exists."
  lane :install_phoenix_hovan do
    sh(xcodebuild_command("build"))
    app = built_app_path
    UI.user_error!("Phoenix Hovan currently builds a framework, not an installable .app. Add an app host target before install/launch can complete.") unless app

    simulator = booted_simulator_id
    unless simulator
      sh("xcrun simctl boot #{Shellwords.escape(SIMULATOR_NAME)} || true")
      simulator = booted_simulator_id
    end

    UI.user_error!("No booted simulator available. Set SIMULATOR_NAME or boot a simulator in Xcode.") unless simulator
    sh("xcrun simctl install #{simulator} #{Shellwords.escape(app)}")
  end

  desc "Install and launch Phoenix Hovan when an app product exists."
  lane :launch_phoenix_hovan do
    install_phoenix_hovan
    app = built_app_path
    bundle_id = sh("/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' #{Shellwords.escape(File.join(app, "Info.plist"))}", log: false).strip
    simulator = booted_simulator_id
    UI.user_error!("No booted simulator available after install.") unless simulator
    sh("xcrun simctl launch #{simulator} #{Shellwords.escape(bundle_id)}")
  end

  desc "Show the App Store Connect credentials required before inventory import."
  lane :app_store_connect_handoff do
    required = ["ASC_KEY_ID", "ASC_ISSUER_ID"]
    missing = required.select { |key| ENV[key].to_s.strip.empty? }
    key_source_present = !ENV["ASC_KEY_PATH"].to_s.strip.empty? || !ENV["ASC_KEY_CONTENT"].to_s.strip.empty?

    unless missing.empty? && key_source_present
      UI.user_error!("Set ASC_KEY_ID, ASC_ISSUER_ID, and ASC_KEY_PATH or ASC_KEY_CONTENT in your secret manager before App Store Connect import.")
    end

    UI.message("App Store Connect credentials are present. Keep private keys out of the repository and map inventory by bundle ID, SKU, Apple ID, platform, and review status.")
  end
end
