
/// A photo.
public struct Photo {

    /// The unique identifier of the photo.
    public let id: Int

    /// The `id` property of the `Album` that contains this photo.
    public let albumId: Int

    /// The title of the photo.
    public let title: String

    /// The url of the photo.
    public let url: String

    /// The thumbnail url of the photo.
    public let thumbnailUrl: String

}
