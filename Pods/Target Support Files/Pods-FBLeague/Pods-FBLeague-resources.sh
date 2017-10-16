#!/bin/sh
set -e

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

# This protects against multiple targets copying the same framework dependency at the same time. The solution
# was originally proposed here: https://lists.samba.org/archive/rsync/2008-February/020158.html
RSYNC_PROTECT_TMP_FILES=(--filter "P .*.??????")

case "${TARGETED_DEVICE_FAMILY}" in
  1,2)
    TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
    ;;
  1)
    TARGET_DEVICE_ARGS="--target-device iphone"
    ;;
  2)
    TARGET_DEVICE_ARGS="--target-device ipad"
    ;;
  3)
    TARGET_DEVICE_ARGS="--target-device tv"
    ;;
  4)
    TARGET_DEVICE_ARGS="--target-device watch"
    ;;
  *)
    TARGET_DEVICE_ARGS="--target-device mac"
    ;;
esac

install_resource()
{
  if [[ "$1" = /* ]] ; then
    RESOURCE_PATH="$1"
  else
    RESOURCE_PATH="${PODS_ROOT}/$1"
  fi
  if [[ ! -e "$RESOURCE_PATH" ]] ; then
    cat << EOM
error: Resource "$RESOURCE_PATH" not found. Run 'pod install' to update the copy resources script.
EOM
    exit 1
  fi
  case $RESOURCE_PATH in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.framework)
      echo "mkdir -p ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      mkdir -p "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" $RESOURCE_PATH ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH"`.mom\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm\"" || true
      xcrun mapc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE="$RESOURCE_PATH"
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    *)
      echo "$RESOURCE_PATH" || true
      echo "$RESOURCE_PATH" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/back-arrow@2x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/back-arrow@3x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/check_success@2x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/check_success@3x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/Expression.plist"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/fail@2x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/fail@3x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/press_btn_green@2x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/press_btn_green@3x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/refresh@2x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/refresh@3x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/success@2x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/success@3x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/ClippedExpression.bundle"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumAddBtn@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumComment@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumComment@3x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumLike@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumLike@3x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumOperateMore@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumOperateMore@3x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumOperateMoreHL@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumOperateMoreHL@3x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumOperateMoreViewBkg@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/Camera@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/Camera@3x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/Like@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/Like@3x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/LikeCmtBg@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/LikeCmtBg@3x.png"
  install_resource "${PODS_ROOT}/IQKeyboardManager/IQKeyboardManager/Resources/IQKeyboardManager.bundle"
  install_resource "${PODS_ROOT}/MJPhotoBrowser/MJPhotoBrowser/MJPhotoBrowser/MJPhotoBrowser.bundle"
  install_resource "${PODS_ROOT}/MJRefresh/MJRefresh/MJRefresh.bundle"
  install_resource "${PODS_ROOT}/QMUIKit/QMUIKit/UIResources/QMUIResources.bundle"
  install_resource "${PODS_ROOT}/QMUIKit/QMUIKit/UIResources/QMUI_QQEmotion.bundle"
  install_resource "${PODS_ROOT}/SVProgressHUD/SVProgressHUD/SVProgressHUD.bundle"
  install_resource "${PODS_ROOT}/TZImagePickerController/TZImagePickerController/TZImagePickerController/TZImagePickerController.bundle"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/back-arrow@2x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/back-arrow@3x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/check_success@2x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/check_success@3x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/Expression.plist"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/fail@2x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/fail@3x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/press_btn_green@2x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/press_btn_green@3x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/refresh@2x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/refresh@3x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/success@2x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/success@3x.png"
  install_resource "${PODS_ROOT}/DFCommon/DFCommon/DFCommon/Resource/ClippedExpression.bundle"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumAddBtn@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumComment@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumComment@3x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumLike@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumLike@3x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumOperateMore@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumOperateMore@3x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumOperateMoreHL@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumOperateMoreHL@3x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/AlbumOperateMoreViewBkg@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/Camera@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/Camera@3x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/Like@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/Like@3x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/LikeCmtBg@2x.png"
  install_resource "${PODS_ROOT}/DFTimelineView/DFTimelineView/DFTimelineView/Resource/LikeCmtBg@3x.png"
  install_resource "${PODS_ROOT}/IQKeyboardManager/IQKeyboardManager/Resources/IQKeyboardManager.bundle"
  install_resource "${PODS_ROOT}/MJPhotoBrowser/MJPhotoBrowser/MJPhotoBrowser/MJPhotoBrowser.bundle"
  install_resource "${PODS_ROOT}/MJRefresh/MJRefresh/MJRefresh.bundle"
  install_resource "${PODS_ROOT}/QMUIKit/QMUIKit/UIResources/QMUIResources.bundle"
  install_resource "${PODS_ROOT}/QMUIKit/QMUIKit/UIResources/QMUI_QQEmotion.bundle"
  install_resource "${PODS_ROOT}/SVProgressHUD/SVProgressHUD/SVProgressHUD.bundle"
  install_resource "${PODS_ROOT}/TZImagePickerController/TZImagePickerController/TZImagePickerController/TZImagePickerController.bundle"
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]] && [[ "${SKIP_INSTALL}" == "NO" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "$XCASSET_FILES" ]
then
  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "${PODS_ROOT}*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
