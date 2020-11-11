
FRAMEWORKS_PATH="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"
LINK_READER_FRAMEWORK_NAME="LinkReaderKit.framework"
LINK_READER_FRAMEWORK="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/${LINK_READER_FRAMEWORK_NAME}"
LINK_READER_BINARY="${LINK_READER_FRAMEWORK}/LinkReaderKit"

find "$LINK_READER_FRAMEWORK" -name '*.framework' -type d | while read -r FRAMEWORK
do

FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)
FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"

ARCHS=$(lipo -info "$FRAMEWORK_EXECUTABLE_PATH" | rev | cut -d ':' -f1 | rev)

for ARCH in $ARCHS; do
if [[ "$VALID_ARCHS" != *"$ARCH"* ]]; then
lipo -remove "$ARCH" -output "$FRAMEWORK_EXECUTABLE_PATH" "$FRAMEWORK_EXECUTABLE_PATH" || exit 1
echo "Removed $ARCH from $FRAMEWORK_EXECUTABLE_PATH"
fi
done

done;



find "$LINK_READER_FRAMEWORK" -name '*.framework' -type d | while read -r FRAMEWORK
do
echo "Signing $FRAMEWORK"
codesign -s "$EXPANDED_CODE_SIGN_IDENTITY" --force "${FRAMEWORK}"
FRAMEWORK_NAME=$(basename "$FRAMEWORK")
if [[ "$FRAMEWORK_NAME" != "$LINK_READER_FRAMEWORK_NAME" ]]; then
echo "Moving $FRAMEWORK to ${FRAMEWORKS_PATH}/${FRAMEWORK_NAME}"
rm -rf "${FRAMEWORKS_PATH}/${FRAMEWORK_NAME}"
mv "$FRAMEWORK" "${FRAMEWORKS_PATH}/${FRAMEWORK_NAME}"
fi
done;

echo "Signing $LINK_READER_FRAMEWORK"
codesign -s "$EXPANDED_CODE_SIGN_IDENTITY" --force "${LINK_READER_FRAMEWORK}"

rm -rf "$LINK_READER_FRAMEWORK/Frameworks"

