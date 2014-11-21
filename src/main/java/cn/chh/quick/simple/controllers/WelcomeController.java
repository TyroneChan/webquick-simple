package cn.chh.quick.simple.controllers;

import org.springframework.boot.autoconfigure.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

/**
 * Home Controller.
 *
 * @author TyroneChan, chenhonghong@gmail.com
 * @since 2014/11/21 15:15
 */
@Controller
@EnableAutoConfiguration
public class WelcomeController {

    @RequestMapping("/")
    @ResponseBody
    String home() {
        return "Hello World!";
    }

}