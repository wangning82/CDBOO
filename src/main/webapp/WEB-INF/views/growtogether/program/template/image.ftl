<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Slider with Slideshow Example - Jssor Slider, Carousel, Slideshow with Javascript Source Code</title>
</head>
<body style="background:#fff;">
<!-- it works the same with all jquery version from 1.x to 2.x -->
<script src="${ctxStatic}/static/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/static/jquery-jssor/jssor.slider.mini.js"></script>
<!-- use jssor.slider.debug.js instead for debug -->

<script>
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

        $("#jssor_div").width($(top.document).width()).height($(top.document).height());
        var jssor_slider1 = new $JssorSlider$("slider1_container", options);
    });
</script>
<!-- Jssor Slider Begin -->
<!-- To move inline styles to css file/block, please specify a class name for each element. -->
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
</body>
</html>