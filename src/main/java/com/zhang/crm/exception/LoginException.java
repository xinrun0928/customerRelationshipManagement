package com.zhang.crm.exception;

/**
 * 自定义登陆异常类
 */
public class LoginException extends Exception {

    public LoginException() {
        super();
    }

    public LoginException(String message) {
        super(message);
    }
}
