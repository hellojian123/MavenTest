$(function () {
    $("#KinSlideshow").KinSlideshow({
        moveStyle: "right",
        titleBar: { titleBar_height: 30, titleBar_bgColor: "#08355c", titleBar_alpha: 0 },
        titleFont: { TitleFont_size: 12, TitleFont_color: "#FFFFFF", TitleFont_weight: "normal" },
        btn: { btn_bgColor: "#FFFFFF", btn_bgHoverColor: "#1072aa", btn_fontColor: "#000000",
            btn_fontHoverColor: "#FFFFFF", btn_borderColor: "#cccccc",
            btn_borderHoverColor: "#1188c0", btn_borderWidth: 1
        }
    });
    $("#banner").jcImgScroll({
        arrow: {
            width: 110,
            height: 342,
            x: 220,
            y: 0
        },
        count: 3,
        offsetX: 140,
        NumBtn: true,
        title: false
    });
})
