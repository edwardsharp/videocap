require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/tus"
require "./lib/shrine/storage/google_drive_storage"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
  # store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"),
  # cache: Shrine::Storage::GoogleDriveStorage.new(
  #   prefix: "store",
  #   google_drive_client_secret_path: "config/gclient_secret.json",
  #   drive_public_folder_id: '1pDCgqxi7pLM4I_o6byLdc9EF4bsblEis',
  #   google_drive_options: {
  #     path: proc { |style| "#{id}_#{movie.file_name}_#{style}" },
  #   }
  # ),
  store: Shrine::Storage::GoogleDriveStorage.new(
    prefix: "store",
    google_drive_client_secret_path: "config/gclient_secret.json",
    drive_public_folder_id: '1pDCgqxi7pLM4I_o6byLdc9EF4bsblEis'
  ),
  tus:   Shrine::Storage::Tus.new,
}

Shrine.plugin :sequel
Shrine.plugin :logging
Shrine.plugin :cached_attachment_data
