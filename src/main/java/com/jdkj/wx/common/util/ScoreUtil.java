package com.jdkj.wx.common.util;

public class ScoreUtil {
	
    public static int val(int value) {
        switch (value) {
        case 1:
            return 1;
        case 2:
            return 2;
        case 3:
            return 4;
        case 4:
            return 6;
        case 5:
            return 8;
        case 6:
            return 10;
        case 7:
            return 20;
        default:
            return 0;
        }
    }
}
