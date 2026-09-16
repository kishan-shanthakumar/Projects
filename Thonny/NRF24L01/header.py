# Memory Map

NRF_CONFIG =  bytearray([0])
EN_AA =       bytearray([1])
EN_RXADDR =   bytearray([2])
SETUP_AW =    bytearray([3])
SETUP_RETR =  bytearray([4])
RF_CH =       bytearray([5])
RF_SETUP =    bytearray([6])
NRF_STATUS =  bytearray([7])
OBSERVE_TX =  bytearray([8])
CD =          bytearray([9])
RX_ADDR_P0 =  bytearray([10])
RX_ADDR_P1 =  bytearray([11])
RX_ADDR_P2 =  bytearray([12])
RX_ADDR_P3 =  bytearray([13])
RX_ADDR_P4 =  bytearray([14])
RX_ADDR_P5 =  bytearray([15])
TX_ADDR =     bytearray([16])
RX_PW_P0 =    bytearray([17])
RX_PW_P1 =    bytearray([18])
RX_PW_P2 =    bytearray([19])
RX_PW_P3 =    bytearray([20])
RX_PW_P4 =    bytearray([21])
RX_PW_P5 =    bytearray([22])
FIFO_STATUS = bytearray([23])
DYNPD =       bytearray([28])
FEATURE =     bytearray([29])

# Bit Mnemonics

MASK_RX_DR  =6
MASK_TX_DS  =5
MASK_MAX_RT =4
EN_CRC      =3
CRCO        =2
PWR_UP      =1
PRIM_RX     =0
ENAA_P5     =5
ENAA_P4     =4
ENAA_P3     =3
ENAA_P2     =2
ENAA_P1     =1
ENAA_P0     =0
ERX_P5      =5
ERX_P4      =4
ERX_P3      =3
ERX_P2      =2
ERX_P1      =1
ERX_P0      =0
AW          =0
ARD         =4
ARC         =0
PLL_LOCK    =4
CONT_WAVE   =7
RF_DR       =3
RF_PWR      =6
RX_DR       =6
TX_DS       =5
MAX_RT      =4
RX_P_NO     =1
TX_FULL     =0
PLOS_CNT    =4
ARC_CNT     =0
TX_REUSE    =6
FIFO_FULL   =5
TX_EMPTY    =4
RX_FULL     =1
RX_EMPTY    =0
DPL_P5      =5
DPL_P4      =4
DPL_P3      =3
DPL_P2      =2
DPL_P1      =1
DPL_P0      =0
EN_DPL      =2
EN_ACK_PAY  =1
EN_DYN_ACK  =0

# Instruction Mnemonics

R_REGISTER =    bytearray([0])
W_REGISTER =    bytearray([32])
REGISTER_MASK = bytearray([31])
ACTIVATE =      bytearray([80])
R_RX_PL_WID =   bytearray([96])
R_RX_PAYLOAD =  bytearray([97])
W_TX_PAYLOAD =  bytearray([160])
W_ACK_PAYLOAD = bytearray([171])
FLUSH_TX =      bytearray([225])
FLUSH_RX =      bytearray([226])
REUSE_TX_PL =   bytearray([227])
RF24_NOP =      bytearray([255])

# Non P Omissions

LNA_HCURR =   0

# P Model Memory Map

RPD =                 bytearray([0x09])
W_TX_PAYLOAD_NO_ACK = bytearray([0xB0])

# P Model Bit Mnemonics

RF_DR_LOW =   5
RF_DR_HIGH =  3
RF_PWR_LOW =  1
RF_PWR_HIGH = 2