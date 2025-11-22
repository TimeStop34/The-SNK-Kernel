#include ""
enum drviflist {
    Legacy, // 0x0
    StorageMassController, // 0x01
    NetworkController, // 0x02
    Framebuffer, // 0x03

    /* 0x04, Multimedia Devices*/
    MultimediaVideo,
    MultimediaAudio,
    MultimediaComputerTelephony,
    MultimediaAudioDevice,
    MultimediaOther,

    MemoryController, // 0x05

    /* 0x06, Bridges */
    BridgeHost,
    BridgePCI,
    BridgeLegacy,
    BridgeOther,

    /* 0x07, Simple Communication Controller */
    SCCSerial,
    SCCParallel,
    SCCMultiportSerial,
    SCCModem,
    SCCOther,

    /* 0x08, Base System Peripheral */
    BSPPIC,
    BSPDMA,
    BSPTimer,
    BSPRTC,
    BSPPCIHotPlug,
    BSPOther,

    InputKeyboard,
    InputPen,
    InputMouse,
    InputScanner,
    InputGameport,
    InputOther,

    DockingStation, // 0x0A
    Processor, // 0x0B

    /* 0x0C, Serial Bus Controller */
};

typedef struct
{
    int (*is_it_my_device) ();
} driver_t;


typedef struct {
    void (*register_driver_type)(driver_t );
} interface_manager_t;

typedef struct {
    interface_manager_t Legacy;
} driver_interface_managers_list_t;