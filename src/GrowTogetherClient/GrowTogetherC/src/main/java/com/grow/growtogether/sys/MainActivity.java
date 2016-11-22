package com.grow.growtogether.sys;

import android.content.Intent;
import android.os.Message;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.Window;
import android.view.WindowManager;
import android.app.Activity;

import com.grow.growtogether.R;
import android.os.Handler;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    //屏幕宽度
    public static int screenWidth;
    //屏幕高度
    public static int screenHeight;

    //欢迎界面对象
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        DisplayMetrics dm = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);
        //屏幕宽度
        screenWidth = dm.widthPixels;
        //屏幕高度
        screenHeight = dm.heightPixels;

        TextView myTextView = (TextView) findViewById(R.id.textView);
        myTextView.setText(Integer.toString(screenWidth));
        TextView my2TextView = (TextView) findViewById(R.id.textView2);
        my2TextView.setText(Integer.toString(screenHeight));

    }

}
