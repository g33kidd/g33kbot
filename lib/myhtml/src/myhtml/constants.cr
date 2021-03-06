module Myhtml
  lib Lib
    # cat api.h | grep '  MyHTML_TAG_' | ruby -e 'while s = gets; puts s.gsub(",", "").gsub("//", "#"); end;'
    enum MyhtmlTags : LibC::SizeT
      MyHTML_TAG__UNDEF              = 0x000
      MyHTML_TAG__TEXT               = 0x001
      MyHTML_TAG__COMMENT            = 0x002
      MyHTML_TAG__DOCTYPE            = 0x003
      MyHTML_TAG_A                   = 0x004
      MyHTML_TAG_ABBR                = 0x005
      MyHTML_TAG_ACRONYM             = 0x006
      MyHTML_TAG_ADDRESS             = 0x007
      MyHTML_TAG_ANNOTATION_XML      = 0x008
      MyHTML_TAG_APPLET              = 0x009
      MyHTML_TAG_AREA                = 0x00a
      MyHTML_TAG_ARTICLE             = 0x00b
      MyHTML_TAG_ASIDE               = 0x00c
      MyHTML_TAG_AUDIO               = 0x00d
      MyHTML_TAG_B                   = 0x00e
      MyHTML_TAG_BASE                = 0x00f
      MyHTML_TAG_BASEFONT            = 0x010
      MyHTML_TAG_BDI                 = 0x011
      MyHTML_TAG_BDO                 = 0x012
      MyHTML_TAG_BGSOUND             = 0x013
      MyHTML_TAG_BIG                 = 0x014
      MyHTML_TAG_BLINK               = 0x015
      MyHTML_TAG_BLOCKQUOTE          = 0x016
      MyHTML_TAG_BODY                = 0x017
      MyHTML_TAG_BR                  = 0x018
      MyHTML_TAG_BUTTON              = 0x019
      MyHTML_TAG_CANVAS              = 0x01a
      MyHTML_TAG_CAPTION             = 0x01b
      MyHTML_TAG_CENTER              = 0x01c
      MyHTML_TAG_CITE                = 0x01d
      MyHTML_TAG_CODE                = 0x01e
      MyHTML_TAG_COL                 = 0x01f
      MyHTML_TAG_COLGROUP            = 0x020
      MyHTML_TAG_COMMAND             = 0x021
      MyHTML_TAG_COMMENT             = 0x022
      MyHTML_TAG_DATALIST            = 0x023
      MyHTML_TAG_DD                  = 0x024
      MyHTML_TAG_DEL                 = 0x025
      MyHTML_TAG_DETAILS             = 0x026
      MyHTML_TAG_DFN                 = 0x027
      MyHTML_TAG_DIALOG              = 0x028
      MyHTML_TAG_DIR                 = 0x029
      MyHTML_TAG_DIV                 = 0x02a
      MyHTML_TAG_DL                  = 0x02b
      MyHTML_TAG_DT                  = 0x02c
      MyHTML_TAG_EM                  = 0x02d
      MyHTML_TAG_EMBED               = 0x02e
      MyHTML_TAG_FIELDSET            = 0x02f
      MyHTML_TAG_FIGCAPTION          = 0x030
      MyHTML_TAG_FIGURE              = 0x031
      MyHTML_TAG_FONT                = 0x032
      MyHTML_TAG_FOOTER              = 0x033
      MyHTML_TAG_FORM                = 0x034
      MyHTML_TAG_FRAME               = 0x035
      MyHTML_TAG_FRAMESET            = 0x036
      MyHTML_TAG_H1                  = 0x037
      MyHTML_TAG_H2                  = 0x038
      MyHTML_TAG_H3                  = 0x039
      MyHTML_TAG_H4                  = 0x03a
      MyHTML_TAG_H5                  = 0x03b
      MyHTML_TAG_H6                  = 0x03c
      MyHTML_TAG_HEAD                = 0x03d
      MyHTML_TAG_HEADER              = 0x03e
      MyHTML_TAG_HGROUP              = 0x03f
      MyHTML_TAG_HR                  = 0x040
      MyHTML_TAG_HTML                = 0x041
      MyHTML_TAG_I                   = 0x042
      MyHTML_TAG_IFRAME              = 0x043
      MyHTML_TAG_IMAGE               = 0x044
      MyHTML_TAG_IMG                 = 0x045
      MyHTML_TAG_INPUT               = 0x046
      MyHTML_TAG_INS                 = 0x047
      MyHTML_TAG_ISINDEX             = 0x048
      MyHTML_TAG_KBD                 = 0x049
      MyHTML_TAG_KEYGEN              = 0x04a
      MyHTML_TAG_LABEL               = 0x04b
      MyHTML_TAG_LEGEND              = 0x04c
      MyHTML_TAG_LI                  = 0x04d
      MyHTML_TAG_LINK                = 0x04e
      MyHTML_TAG_LISTING             = 0x04f
      MyHTML_TAG_MAIN                = 0x050
      MyHTML_TAG_MAP                 = 0x051
      MyHTML_TAG_MARK                = 0x052
      MyHTML_TAG_MARQUEE             = 0x053
      MyHTML_TAG_MENU                = 0x054
      MyHTML_TAG_MENUITEM            = 0x055
      MyHTML_TAG_META                = 0x056
      MyHTML_TAG_METER               = 0x057
      MyHTML_TAG_MTEXT               = 0x058
      MyHTML_TAG_NAV                 = 0x059
      MyHTML_TAG_NOBR                = 0x05a
      MyHTML_TAG_NOEMBED             = 0x05b
      MyHTML_TAG_NOFRAMES            = 0x05c
      MyHTML_TAG_NOSCRIPT            = 0x05d
      MyHTML_TAG_OBJECT              = 0x05e
      MyHTML_TAG_OL                  = 0x05f
      MyHTML_TAG_OPTGROUP            = 0x060
      MyHTML_TAG_OPTION              = 0x061
      MyHTML_TAG_OUTPUT              = 0x062
      MyHTML_TAG_P                   = 0x063
      MyHTML_TAG_PARAM               = 0x064
      MyHTML_TAG_PLAINTEXT           = 0x065
      MyHTML_TAG_PRE                 = 0x066
      MyHTML_TAG_PROGRESS            = 0x067
      MyHTML_TAG_Q                   = 0x068
      MyHTML_TAG_RB                  = 0x069
      MyHTML_TAG_RP                  = 0x06a
      MyHTML_TAG_RT                  = 0x06b
      MyHTML_TAG_RTC                 = 0x06c
      MyHTML_TAG_RUBY                = 0x06d
      MyHTML_TAG_S                   = 0x06e
      MyHTML_TAG_SAMP                = 0x06f
      MyHTML_TAG_SCRIPT              = 0x070
      MyHTML_TAG_SECTION             = 0x071
      MyHTML_TAG_SELECT              = 0x072
      MyHTML_TAG_SMALL               = 0x073
      MyHTML_TAG_SOURCE              = 0x074
      MyHTML_TAG_SPAN                = 0x075
      MyHTML_TAG_STRIKE              = 0x076
      MyHTML_TAG_STRONG              = 0x077
      MyHTML_TAG_STYLE               = 0x078
      MyHTML_TAG_SUB                 = 0x079
      MyHTML_TAG_SUMMARY             = 0x07a
      MyHTML_TAG_SUP                 = 0x07b
      MyHTML_TAG_SVG                 = 0x07c
      MyHTML_TAG_TABLE               = 0x07d
      MyHTML_TAG_TBODY               = 0x07e
      MyHTML_TAG_TD                  = 0x07f
      MyHTML_TAG_TEMPLATE            = 0x080
      MyHTML_TAG_TEXTAREA            = 0x081
      MyHTML_TAG_TFOOT               = 0x082
      MyHTML_TAG_TH                  = 0x083
      MyHTML_TAG_THEAD               = 0x084
      MyHTML_TAG_TIME                = 0x085
      MyHTML_TAG_TITLE               = 0x086
      MyHTML_TAG_TR                  = 0x087
      MyHTML_TAG_TRACK               = 0x088
      MyHTML_TAG_TT                  = 0x089
      MyHTML_TAG_U                   = 0x08a
      MyHTML_TAG_UL                  = 0x08b
      MyHTML_TAG_VAR                 = 0x08c
      MyHTML_TAG_VIDEO               = 0x08d
      MyHTML_TAG_WBR                 = 0x08e
      MyHTML_TAG_XMP                 = 0x08f
      MyHTML_TAG_ALTGLYPH            = 0x090
      MyHTML_TAG_ALTGLYPHDEF         = 0x091
      MyHTML_TAG_ALTGLYPHITEM        = 0x092
      MyHTML_TAG_ANIMATE             = 0x093
      MyHTML_TAG_ANIMATECOLOR        = 0x094
      MyHTML_TAG_ANIMATEMOTION       = 0x095
      MyHTML_TAG_ANIMATETRANSFORM    = 0x096
      MyHTML_TAG_CIRCLE              = 0x097
      MyHTML_TAG_CLIPPATH            = 0x098
      MyHTML_TAG_COLOR_PROFILE       = 0x099
      MyHTML_TAG_CURSOR              = 0x09a
      MyHTML_TAG_DEFS                = 0x09b
      MyHTML_TAG_DESC                = 0x09c
      MyHTML_TAG_ELLIPSE             = 0x09d
      MyHTML_TAG_FEBLEND             = 0x09e
      MyHTML_TAG_FECOLORMATRIX       = 0x09f
      MyHTML_TAG_FECOMPONENTTRANSFER = 0x0a0
      MyHTML_TAG_FECOMPOSITE         = 0x0a1
      MyHTML_TAG_FECONVOLVEMATRIX    = 0x0a2
      MyHTML_TAG_FEDIFFUSELIGHTING   = 0x0a3
      MyHTML_TAG_FEDISPLACEMENTMAP   = 0x0a4
      MyHTML_TAG_FEDISTANTLIGHT      = 0x0a5
      MyHTML_TAG_FEDROPSHADOW        = 0x0a6
      MyHTML_TAG_FEFLOOD             = 0x0a7
      MyHTML_TAG_FEFUNCA             = 0x0a8
      MyHTML_TAG_FEFUNCB             = 0x0a9
      MyHTML_TAG_FEFUNCG             = 0x0aa
      MyHTML_TAG_FEFUNCR             = 0x0ab
      MyHTML_TAG_FEGAUSSIANBLUR      = 0x0ac
      MyHTML_TAG_FEIMAGE             = 0x0ad
      MyHTML_TAG_FEMERGE             = 0x0ae
      MyHTML_TAG_FEMERGENODE         = 0x0af
      MyHTML_TAG_FEMORPHOLOGY        = 0x0b0
      MyHTML_TAG_FEOFFSET            = 0x0b1
      MyHTML_TAG_FEPOINTLIGHT        = 0x0b2
      MyHTML_TAG_FESPECULARLIGHTING  = 0x0b3
      MyHTML_TAG_FESPOTLIGHT         = 0x0b4
      MyHTML_TAG_FETILE              = 0x0b5
      MyHTML_TAG_FETURBULENCE        = 0x0b6
      MyHTML_TAG_FILTER              = 0x0b7
      MyHTML_TAG_FONT_FACE           = 0x0b8
      MyHTML_TAG_FONT_FACE_FORMAT    = 0x0b9
      MyHTML_TAG_FONT_FACE_NAME      = 0x0ba
      MyHTML_TAG_FONT_FACE_SRC       = 0x0bb
      MyHTML_TAG_FONT_FACE_URI       = 0x0bc
      MyHTML_TAG_FOREIGNOBJECT       = 0x0bd
      MyHTML_TAG_G                   = 0x0be
      MyHTML_TAG_GLYPH               = 0x0bf
      MyHTML_TAG_GLYPHREF            = 0x0c0
      MyHTML_TAG_HKERN               = 0x0c1
      MyHTML_TAG_LINE                = 0x0c2
      MyHTML_TAG_LINEARGRADIENT      = 0x0c3
      MyHTML_TAG_MARKER              = 0x0c4
      MyHTML_TAG_MASK                = 0x0c5
      MyHTML_TAG_METADATA            = 0x0c6
      MyHTML_TAG_MISSING_GLYPH       = 0x0c7
      MyHTML_TAG_MPATH               = 0x0c8
      MyHTML_TAG_PATH                = 0x0c9
      MyHTML_TAG_PATTERN             = 0x0ca
      MyHTML_TAG_POLYGON             = 0x0cb
      MyHTML_TAG_POLYLINE            = 0x0cc
      MyHTML_TAG_RADIALGRADIENT      = 0x0cd
      MyHTML_TAG_RECT                = 0x0ce
      MyHTML_TAG_SET                 = 0x0cf
      MyHTML_TAG_STOP                = 0x0d0
      MyHTML_TAG_SWITCH              = 0x0d1
      MyHTML_TAG_SYMBOL              = 0x0d2
      MyHTML_TAG_TEXT                = 0x0d3
      MyHTML_TAG_TEXTPATH            = 0x0d4
      MyHTML_TAG_TREF                = 0x0d5
      MyHTML_TAG_TSPAN               = 0x0d6
      MyHTML_TAG_USE                 = 0x0d7
      MyHTML_TAG_VIEW                = 0x0d8
      MyHTML_TAG_VKERN               = 0x0d9
      MyHTML_TAG_MATH                = 0x0da
      MyHTML_TAG_MACTION             = 0x0db
      MyHTML_TAG_MALIGNGROUP         = 0x0dc
      MyHTML_TAG_MALIGNMARK          = 0x0dd
      MyHTML_TAG_MENCLOSE            = 0x0de
      MyHTML_TAG_MERROR              = 0x0df
      MyHTML_TAG_MFENCED             = 0x0e0
      MyHTML_TAG_MFRAC               = 0x0e1
      MyHTML_TAG_MGLYPH              = 0x0e2
      MyHTML_TAG_MI                  = 0x0e3
      MyHTML_TAG_MLABELEDTR          = 0x0e4
      MyHTML_TAG_MLONGDIV            = 0x0e5
      MyHTML_TAG_MMULTISCRIPTS       = 0x0e6
      MyHTML_TAG_MN                  = 0x0e7
      MyHTML_TAG_MO                  = 0x0e8
      MyHTML_TAG_MOVER               = 0x0e9
      MyHTML_TAG_MPADDED             = 0x0ea
      MyHTML_TAG_MPHANTOM            = 0x0eb
      MyHTML_TAG_MROOT               = 0x0ec
      MyHTML_TAG_MROW                = 0x0ed
      MyHTML_TAG_MS                  = 0x0ee
      MyHTML_TAG_MSCARRIES           = 0x0ef
      MyHTML_TAG_MSCARRY             = 0x0f0
      MyHTML_TAG_MSGROUP             = 0x0f1
      MyHTML_TAG_MSLINE              = 0x0f2
      MyHTML_TAG_MSPACE              = 0x0f3
      MyHTML_TAG_MSQRT               = 0x0f4
      MyHTML_TAG_MSROW               = 0x0f5
      MyHTML_TAG_MSTACK              = 0x0f6
      MyHTML_TAG_MSTYLE              = 0x0f7
      MyHTML_TAG_MSUB                = 0x0f8
      MyHTML_TAG_MSUP                = 0x0f9
      MyHTML_TAG_MSUBSUP             = 0x0fa
      MyHTML_TAG__END_OF_FILE        = 0x0fb
      MyHTML_TAG_FIRST_ENTRY         = MyHTML_TAG__TEXT
      MyHTML_TAG_LAST_ENTRY          = 0x0fc
    end

    # cat api.h | grep '  MyHTML_ENCODING_' | ruby -e 'while s = gets; puts s.gsub(",", "").gsub("//", "#"); end;'
    enum MyhtmlEncodingList
      MyHTML_ENCODING_DEFAULT = 0x00
      #  MyHTML_ENCODING_AUTO             = 0x01 # future
      #  MyHTML_ENCODING_CUSTOM           = 0x02 # future
      MyHTML_ENCODING_UTF_8          = 0x00 # default encoding
      MyHTML_ENCODING_UTF_16LE       = 0x04
      MyHTML_ENCODING_UTF_16BE       = 0x05
      MyHTML_ENCODING_X_USER_DEFINED = 0x06
      MyHTML_ENCODING_BIG5           = 0x07
      MyHTML_ENCODING_EUC_KR         = 0x08
      MyHTML_ENCODING_GB18030        = 0x09
      MyHTML_ENCODING_IBM866         = 0x0a
      MyHTML_ENCODING_ISO_8859_10    = 0x0b
      MyHTML_ENCODING_ISO_8859_13    = 0x0c
      MyHTML_ENCODING_ISO_8859_14    = 0x0d
      MyHTML_ENCODING_ISO_8859_15    = 0x0e
      MyHTML_ENCODING_ISO_8859_16    = 0x0f
      MyHTML_ENCODING_ISO_8859_2     = 0x10
      MyHTML_ENCODING_ISO_8859_3     = 0x11
      MyHTML_ENCODING_ISO_8859_4     = 0x12
      MyHTML_ENCODING_ISO_8859_5     = 0x13
      MyHTML_ENCODING_ISO_8859_6     = 0x14
      MyHTML_ENCODING_ISO_8859_7     = 0x15
      MyHTML_ENCODING_ISO_8859_8     = 0x16
      MyHTML_ENCODING_KOI8_R         = 0x17
      MyHTML_ENCODING_KOI8_U         = 0x18
      MyHTML_ENCODING_MACINTOSH      = 0x19
      MyHTML_ENCODING_WINDOWS_1250   = 0x1a
      MyHTML_ENCODING_WINDOWS_1251   = 0x1b
      MyHTML_ENCODING_WINDOWS_1252   = 0x1c
      MyHTML_ENCODING_WINDOWS_1253   = 0x1d
      MyHTML_ENCODING_WINDOWS_1254   = 0x1e
      MyHTML_ENCODING_WINDOWS_1255   = 0x1f
      MyHTML_ENCODING_WINDOWS_1256   = 0x20
      MyHTML_ENCODING_WINDOWS_1257   = 0x21
      MyHTML_ENCODING_WINDOWS_1258   = 0x22
      MyHTML_ENCODING_WINDOWS_874    = 0x23
      MyHTML_ENCODING_X_MAC_CYRILLIC = 0x24
      MyHTML_ENCODING_ISO_2022_JP    = 0x25
      MyHTML_ENCODING_GBK            = 0x26
      MyHTML_ENCODING_SHIFT_JIS      = 0x27
      MyHTML_ENCODING_EUC_JP         = 0x28
      MyHTML_ENCODING_ISO_8859_8_I   = 0x29
      MyHTML_ENCODING_LAST_ENTRY     = 0x2a
    end

    # cat api.h | grep '  MyHTML_STATUS_' | ruby -e 'while s = gets; puts s.gsub(",", "").gsub("//", "#"); end;'
    enum MyhtmlStatus
      MyHTML_STATUS_OK                                 = 0x0000
      MyHTML_STATUS_ERROR_MEMORY_ALLOCATION            = 0x0001
      MyHTML_STATUS_THREAD_ERROR_MEMORY_ALLOCATION     = 0x0009
      MyHTML_STATUS_THREAD_ERROR_LIST_INIT             = 0x000a
      MyHTML_STATUS_THREAD_ERROR_ATTR_MALLOC           = 0x000b
      MyHTML_STATUS_THREAD_ERROR_ATTR_INIT             = 0x000c
      MyHTML_STATUS_THREAD_ERROR_ATTR_SET              = 0x000d
      MyHTML_STATUS_THREAD_ERROR_ATTR_DESTROY          = 0x000e
      MyHTML_STATUS_THREAD_ERROR_NO_SLOTS              = 0x000f
      MyHTML_STATUS_THREAD_ERROR_BATCH_INIT            = 0x0010
      MyHTML_STATUS_THREAD_ERROR_WORKER_MALLOC         = 0x0011
      MyHTML_STATUS_THREAD_ERROR_WORKER_SEM_CREATE     = 0x0012
      MyHTML_STATUS_THREAD_ERROR_WORKER_THREAD_CREATE  = 0x0013
      MyHTML_STATUS_THREAD_ERROR_MASTER_THREAD_CREATE  = 0x0014
      MyHTML_STATUS_THREAD_ERROR_SEM_PREFIX_MALLOC     = 0x0032
      MyHTML_STATUS_THREAD_ERROR_SEM_CREATE            = 0x0033
      MyHTML_STATUS_THREAD_ERROR_QUEUE_MALLOC          = 0x003c
      MyHTML_STATUS_THREAD_ERROR_QUEUE_NODES_MALLOC    = 0x003d
      MyHTML_STATUS_THREAD_ERROR_QUEUE_NODE_MALLOC     = 0x003e
      MyHTML_STATUS_THREAD_ERROR_MUTEX_MALLOC          = 0x0046
      MyHTML_STATUS_THREAD_ERROR_MUTEX_INIT            = 0x0047
      MyHTML_STATUS_THREAD_ERROR_MUTEX_LOCK            = 0x0048
      MyHTML_STATUS_THREAD_ERROR_MUTEX_UNLOCK          = 0x0049
      MyHTML_STATUS_RULES_ERROR_MEMORY_ALLOCATION      = 0x0064
      MyHTML_STATUS_PERF_ERROR_COMPILED_WITHOUT_PERF   = 0x00c8
      MyHTML_STATUS_PERF_ERROR_FIND_CPU_CLOCK          = 0x00c9
      MyHTML_STATUS_TOKENIZER_ERROR_MEMORY_ALLOCATION  = 0x012c
      MyHTML_STATUS_TOKENIZER_ERROR_FRAGMENT_INIT      = 0x012d
      MyHTML_STATUS_TAGS_ERROR_MEMORY_ALLOCATION       = 0x0190
      MyHTML_STATUS_TAGS_ERROR_MCOBJECT_CREATE         = 0x0191
      MyHTML_STATUS_TAGS_ERROR_MCOBJECT_MALLOC         = 0x0192
      MyHTML_STATUS_TAGS_ERROR_MCOBJECT_CREATE_NODE    = 0x0193
      MyHTML_STATUS_TAGS_ERROR_CACHE_MEMORY_ALLOCATION = 0x0194
      MyHTML_STATUS_TAGS_ERROR_INDEX_MEMORY_ALLOCATION = 0x0195
      MyHTML_STATUS_TREE_ERROR_MEMORY_ALLOCATION       = 0x01f4
      MyHTML_STATUS_TREE_ERROR_MCOBJECT_CREATE         = 0x01f5
      MyHTML_STATUS_TREE_ERROR_MCOBJECT_INIT           = 0x01f6
      MyHTML_STATUS_TREE_ERROR_MCOBJECT_CREATE_NODE    = 0x01f7
      MyHTML_STATUS_TREE_ERROR_INCOMING_BUFFER_CREATE  = 0x01f8
      MyHTML_STATUS_ATTR_ERROR_ALLOCATION              = 0x0258
      MyHTML_STATUS_ATTR_ERROR_CREATE                  = 0x0259
      MyHTML_STATUS_STREAM_BUFFER_ERROR_CREATE         = 0x0300
      MyHTML_STATUS_STREAM_BUFFER_ERROR_INIT           = 0x0301
      MyHTML_STATUS_STREAM_BUFFER_ENTRY_ERROR_CREATE   = 0x0302
      MyHTML_STATUS_STREAM_BUFFER_ENTRY_ERROR_INIT     = 0x0303
      MyHTML_STATUS_STREAM_BUFFER_ERROR_ADD_ENTRY      = 0x0304
      MyHTML_STATUS_MCOBJECT_ERROR_CACHE_CREATE        = 0x0340
      MyHTML_STATUS_MCOBJECT_ERROR_CHUNK_CREATE        = 0x0341
      MyHTML_STATUS_MCOBJECT_ERROR_CHUNK_INIT          = 0x0342
      MyHTML_STATUS_MCOBJECT_ERROR_CACHE_REALLOC       = 0x0343
    end

    # cat api.h | grep '  MyHTML_NAMESPACE_' | ruby -e 'while s = gets; puts s.gsub(",", "").gsub("//", "#"); end;'
    enum MyhtmlNamespace
      MyHTML_NAMESPACE_UNDEF      = 0x00
      MyHTML_NAMESPACE_HTML       = 0x01
      MyHTML_NAMESPACE_MATHML     = 0x02
      MyHTML_NAMESPACE_SVG        = 0x03
      MyHTML_NAMESPACE_XLINK      = 0x04
      MyHTML_NAMESPACE_XML        = 0x05
      MyHTML_NAMESPACE_XMLNS      = 0x06
      MyHTML_NAMESPACE_ANY        = 0x07
      MyHTML_NAMESPACE_LAST_ENTRY = 0x07
    end

    # cat api.h | grep '  MyHTML_OPTIONS_' | ruby -e 'while s = gets; puts s.gsub(",", "").gsub("//", "#"); end;'
    enum MyhtmlOptions
      MyHTML_OPTIONS_DEFAULT               = 0x00
      MyHTML_OPTIONS_PARSE_MODE_SINGLE     = 0x01
      MyHTML_OPTIONS_PARSE_MODE_ALL_IN_ONE = 0x02
      MyHTML_OPTIONS_PARSE_MODE_SEPARATELY = 0x04
    end

    # cat api.h | grep '  MyHTML_TREE_PARSE_' | ruby -e 'while s = gets; puts s.gsub(",", "").gsub("//", "#"); end;'
    enum MyhtmlTreeParseFlags
      MyHTML_TREE_PARSE_FLAGS_CLEAN                   = 0x000
      MyHTML_TREE_PARSE_FLAGS_WITHOUT_BUILD_TREE      = 0x001
      MyHTML_TREE_PARSE_FLAGS_WITHOUT_PROCESS_TOKEN   = 0x003
      MyHTML_TREE_PARSE_FLAGS_SKIP_WHITESPACE_TOKEN   = 0x004 # /* skip ws not for RCDATA RAWTEXT CDATA PLAINTEXT */
      MyHTML_TREE_PARSE_FLAGS_WITHOUT_DOCTYPE_IN_TREE = 0x008
    end
  end
end
