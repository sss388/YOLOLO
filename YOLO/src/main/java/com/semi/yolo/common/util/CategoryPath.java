package com.semi.yolo.common.util;

public class CategoryPath {
    private static final String BASE_UPLOAD_PATH = "/resources/upload/";

    public static String getMainFileUploadPath(String category) {
        return BASE_UPLOAD_PATH + "main_file/" + category + "/";
    }

    public static String getUploadFileUploadPath(String category) {
        return BASE_UPLOAD_PATH + "upload_file/" + category + "/";
    }

}
