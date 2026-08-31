use super::Object;

#[allow(unused)]
pub trait DirectoryObject: Object {
    // lookup() и entries() удалены — теперь они в DirectoryHandle
}