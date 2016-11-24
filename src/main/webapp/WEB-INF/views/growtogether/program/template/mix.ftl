<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>test</title>
    <style type="text/css">
        body {margin: 0}
        .c {overflow: hidden;position: absolute;left: 0;top: 0px;right: 0;bottom: 0;}
        .d {background: #ccc;border: 5px solid red;height: 500px;}
        .d2 {background: green;border: 5px solid red;height: 500px;}
        p {height: 1000px;margin: 0}
        .f1,.f2 {float: left;height: 100%;width: 300px;border: 5px solid #ccc; box-sizing: border-box;}
        .e {overflow: hidden;}
    </style>

    <link href="${ctxStatic}/static/jquery-jplayer/skin/blue.monday/css/jplayer.blue.monday.min.css" rel="stylesheet" type="text/css" />
    <script src="${ctxStatic}/static/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic}/static/jquery-jplayer/jplayer/jquery.jplayer.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/static/jquery-jssor/jssor.slider.mini.js"></script>

    <script type="text/javascript">
        //<![CDATA[
        $(document).ready(function() {

            $("#jquery_jplayer_1").jPlayer({
                ready: function () {
                    $(this).jPlayer("setMedia", {
                        title: "",
                        m4v: "${videoContent}"
                    }).jPlayer("play");
                },

                ended: function() {
                    $(this).jPlayer("play");
                },

                swfPath: "${ctxStatic}/static/jquery-jplayer/jplayer",
                supplied: "webmv, ogv, m4v",

//                fullWindow: true,
//                fullScreen: true,
                size: {
                    width: $(top.document).width()/2,
                    height: $(top.document).height()/2,
                    cssClass: "jp-video-360p"
                },

                useStateClassSkin: true,
                autoBlur: false,
                smoothPlayBar: true,
                keyEnabled: true,
                remainingDuration: true,
                toggleDuration: true
            });

        });
        //]]>

        jQuery(document).ready(function ($) {
            //Reference http://www.jssor.com/development/slider-with-slideshow-jquery.html
            //Reference http://www.jssor.com/development/tool-slideshow-transition-viewer.html

            var _SlideshowTransitions = [
                //Fade
                { $Duration: 1200, $Opacity: 2 }
            ];

            var options = {
                $SlideDuration: 500,                                //[Optional] Specifies default duration (swipe) for slide in milliseconds, default value is 500
                $DragOrientation: 3,                                //[Optional] Orientation to drag slide, 0 no drag, 1 horizental, 2 vertical, 3 either, default value is 1 (Note that the $DragOrientation should be the same as $PlayOrientation when $Cols is greater than 1, or parking position is not 0)
                $AutoPlay: true,                                    //[Optional] Whether to auto play, to enable slideshow, this option must be set to true, default value is false
                $Idle: ${image_idle},                            //[Optional] Interval (in milliseconds) to go for next slide since the previous stopped if the slider is auto playing, default value is 3000
                $SlideshowOptions: {                                //[Optional] Options to specify and enable slideshow or not
                    $Class: $JssorSlideshowRunner$,                 //[Required] Class to create instance of slideshow
                    $Transitions: _SlideshowTransitions,            //[Required] An array of slideshow transitions to play slideshow
                    $TransitionsOrder: 1,                           //[Optional] The way to choose transition to play slide, 1 Sequence, 0 Random
                    $ShowLink: false                                    //[Optional] Whether to bring slide link on top of the slider when slideshow is running, default value is false
                }
            };

            $("#jssor_div").width($(top.document).width()/2).height($(top.document).height()/2);
            var jssor_slider1 = new $JssorSlider$("slider1_container", options);
        });



    </script>
</head>

<body>
<div class='c frameset' cols="50%, *">

    <div class='frameset' rows="50%, *">
        <div class=''>
            <div id="jp_container_1" class="jp-video jp-video-360p" role="application" aria-label="media player">
                <div class="jp-type-single">
                    <div id="jquery_jplayer_1" class="jp-jplayer"></div>
                    <div class="jp-gui">
                        <div class="jp-video-play">
                            <button class="jp-video-play-icon" role="button" tabindex="0">play</button>
                        </div>
                        <div class="jp-interface">
                            <div class="jp-progress">
                                <div class="jp-seek-bar">
                                    <div class="jp-play-bar"></div>
                                </div>
                            </div>
                            <div class="jp-current-time" role="timer" aria-label="time">&nbsp;</div>
                            <div class="jp-duration" role="timer" aria-label="duration">&nbsp;</div>
                            <div class="jp-controls-holder">
                                <div class="jp-controls">
                                    <button class="jp-play" role="button" tabindex="0">play</button>
                                    <button class="jp-stop" role="button" tabindex="0">stop</button>
                                </div>
                                <div class="jp-volume-controls">
                                    <button class="jp-mute" role="button" tabindex="0">mute</button>
                                    <button class="jp-volume-max" role="button" tabindex="0">max volume</button>
                                    <div class="jp-volume-bar">
                                        <div class="jp-volume-bar-value"></div>
                                    </div>
                                </div>
                                <div class="jp-toggles">
                                    <button class="jp-repeat" role="button" tabindex="0">repeat</button>
                                    <button class="jp-full-screen" role="button" tabindex="0">full screen</button>
                                </div>
                            </div>
                            <div class="jp-details">
                                <div class="jp-title" aria-label="title">&nbsp;</div>
                            </div>
                        </div>
                    </div>
                    <div class="jp-no-solution">
                        <span>Update Required</span>
                        To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
                    </div>
                </div>
            </div>
        </div>
        <div class=''>
            <div id="slider1_container" style="position: relative; width: 600px;
        height: 300px;">

                <!-- Loading Screen -->
                <div u="loading" style="position: absolute; top: 0px; left: 0px;">
                    <div style="filter: alpha(opacity=70); opacity:0.7; position: absolute; display: block;
                background-color: #000; top: 0px; left: 0px;width: 100%;height:100%;">
                    </div>
                    <div style="position: absolute; display: block; background: url(../img/loading.gif) no-repeat center center;
                top: 0px; left: 0px;width: 100%;height:100%;">
                    </div>
                </div>

                <!-- Slides Container -->
                <div id="jssor_div" u="slides" style="cursor: move; position: absolute; left: 0px; top: 0px; width: 600px; height: 300px;
            overflow: hidden;">
                <#list imageList as image>
                    <div>
                        <img u=image src="${image}" />
                    </div>
                </#list>
                </div>
                <a style="display: none" href="http://www.jssor.com">jQuery Slider</a>
            </div>
        </div>
    </div>

    <div class='' style="position: relative;min-height: 100px;">
        <div style='position: absolute;left:0;top:0;right:0;bottom:40px;width: 100%;overflow: hidden'>
            <table border="0" cellpadding="20px" cellspacing="10px">
                <tr>
                    <td align="center" style="font-size: 50px">${title}<td>
                </tr>
                <tr>
                    <td style="font-size: 20px">${txtContent}<td>
                </tr>
            </table>
        </div>
    </div>

</div>

<script type="text/javascript" src='${ctxStatic}/static/jquery-frameset/star-frameset.js'></script>
<script type="text/javascript"></script>

</body>
</html>