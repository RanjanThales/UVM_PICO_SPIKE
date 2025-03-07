// Copyright 2020 OpenHW Group
// Copyright 2020 Datum Technology Corporation
// Copyright 2020 Silicon Labs, Inc.
//
// Licensed under the Solderpad Hardware Licence, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://solderpad.org/licenses/
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


`ifndef __UVMA_CORE_CNTRL_TDEFS_SV__
`define __UVMA_CORE_CNTRL_TDEFS_SV__


typedef enum int unsigned {
    MXL_32 = 32,
    MXL_64 = 64,
    MXL_128 = 128
} corev_mxl_t;

typedef enum bit[11:0] {
  USTATUS        = 'h000,
  UIE            = 'h004,
  UTVEC          = 'h005,
  USCRATCH       = 'h040,
  UEPC           = 'h041,
  UCAUSE         = 'h042,
  UTVAL          = 'h043,
  UIP            = 'h044,
  FFLAGS         = 'h001,
  FRM            = 'h002,
  FCSR           = 'h003,
  CYCLE          = 'hC00,
  TIME           = 'hC01,
  INSTRET        = 'hC02,
  HPMCOUNTER3    = 'hC03,
  HPMCOUNTER4    = 'hC04,
  HPMCOUNTER5    = 'hC05,
  HPMCOUNTER6    = 'hC06,
  HPMCOUNTER7    = 'hC07,
  HPMCOUNTER8    = 'hC08,
  HPMCOUNTER9    = 'hC09,
  HPMCOUNTER10   = 'hC0A,
  HPMCOUNTER11   = 'hC0B,
  HPMCOUNTER12   = 'hC0C,
  HPMCOUNTER13   = 'hC0D,
  HPMCOUNTER14   = 'hC0E,
  HPMCOUNTER15   = 'hC0F,
  HPMCOUNTER16   = 'hC10,
  HPMCOUNTER17   = 'hC11,
  HPMCOUNTER18   = 'hC12,
  HPMCOUNTER19   = 'hC13,
  HPMCOUNTER20   = 'hC14,
  HPMCOUNTER21   = 'hC15,
  HPMCOUNTER22   = 'hC16,
  HPMCOUNTER23   = 'hC17,
  HPMCOUNTER24   = 'hC18,
  HPMCOUNTER25   = 'hC19,
  HPMCOUNTER26   = 'hC1A,
  HPMCOUNTER27   = 'hC1B,
  HPMCOUNTER28   = 'hC1C,
  HPMCOUNTER29   = 'hC1D,
  HPMCOUNTER30   = 'hC1E,
  HPMCOUNTER31   = 'hC1F,
  CYCLEH         = 'hC80,
  TIMEH          = 'hC81,
  INSTRETH       = 'hC82,
  HPMCOUNTER3H   = 'hC83,
  HPMCOUNTER4H   = 'hC84,
  HPMCOUNTER5H   = 'hC85,
  HPMCOUNTER6H   = 'hC86,
  HPMCOUNTER7H   = 'hC87,
  HPMCOUNTER8H   = 'hC88,
  HPMCOUNTER9H   = 'hC89,
  HPMCOUNTER10H  = 'hC8A,
  HPMCOUNTER11H  = 'hC8B,
  HPMCOUNTER12H  = 'hC8C,
  HPMCOUNTER13H  = 'hC8D,
  HPMCOUNTER14H  = 'hC8E,
  HPMCOUNTER15H  = 'hC8F,
  HPMCOUNTER16H  = 'hC90,
  HPMCOUNTER17H  = 'hC91,
  HPMCOUNTER18H  = 'hC92,
  HPMCOUNTER19H  = 'hC93,
  HPMCOUNTER20H  = 'hC94,
  HPMCOUNTER21H  = 'hC95,
  HPMCOUNTER22H  = 'hC96,
  HPMCOUNTER23H  = 'hC97,
  HPMCOUNTER24H  = 'hC98,
  HPMCOUNTER25H  = 'hC99,
  HPMCOUNTER26H  = 'hC9A,
  HPMCOUNTER27H  = 'hC9B,
  HPMCOUNTER28H  = 'hC9C,
  HPMCOUNTER29H  = 'hC9D,
  HPMCOUNTER30H  = 'hC9E,
  HPMCOUNTER31H  = 'hC9F,
  SSTATUS        = 'h100,
  SEDELEG        = 'h102,
  SIDELEG        = 'h103,
  SIE            = 'h104,
  STVEC          = 'h105,
  SCOUNTEREN     = 'h106,
  SSCRATCH       = 'h140,
  SEPC           = 'h141,
  SCAUSE         = 'h142,
  STVAL          = 'h143,
  SIP            = 'h144,
  SATP           = 'h180,
  MVENDORID      = 'hF11,
  MARCHID        = 'hF12,
  MIMPID         = 'hF13,
  MHARTID        = 'hF14,
  MSTATUS        = 'h300,
  MISA           = 'h301,
  MEDELEG        = 'h302,
  MIDELEG        = 'h303,
  MIE            = 'h304,
  MTVEC          = 'h305,
  MCOUNTEREN     = 'h306,
  MENVCFG        = 'h30A,
  MSTATUSH       = 'h310,
  MENVCFGH       = 'h31A,
  MSCRATCH       = 'h340,
  MEPC           = 'h341,
  MCAUSE         = 'h342,
  MTVAL          = 'h343,
  MIP            = 'h344,
  PMPCFG0        = 'h3A0,
  PMPCFG1        = 'h3A1,
  PMPCFG2        = 'h3A2,
  PMPCFG3        = 'h3A3,
  PMPCFG4        = 'h3A4,
  PMPCFG5        = 'h3A5,
  PMPCFG6        = 'h3A6,
  PMPCFG7        = 'h3A7,
  PMPCFG8        = 'h3A8,
  PMPCFG9        = 'h3A9,
  PMPCFG10       = 'h3AA,
  PMPCFG11       = 'h3AB,
  PMPCFG12       = 'h3AC,
  PMPCFG13       = 'h3AD,
  PMPCFG14       = 'h3AE,
  PMPCFG15       = 'h3AF,
  PMPADDR0       = 'h3B0,
  PMPADDR1       = 'h3B1,
  PMPADDR2       = 'h3B2,
  PMPADDR3       = 'h3B3,
  PMPADDR4       = 'h3B4,
  PMPADDR5       = 'h3B5,
  PMPADDR6       = 'h3B6,
  PMPADDR7       = 'h3B7,
  PMPADDR8       = 'h3B8,
  PMPADDR9       = 'h3B9,
  PMPADDR10      = 'h3BA,
  PMPADDR11      = 'h3BB,
  PMPADDR12      = 'h3BC,
  PMPADDR13      = 'h3BD,
  PMPADDR14      = 'h3BE,
  PMPADDR15      = 'h3BF,
  PMPADDR16      = 'h3C0,
  PMPADDR17      = 'h3C1,
  PMPADDR18      = 'h3C2,
  PMPADDR19      = 'h3C3,
  PMPADDR20      = 'h3C4,
  PMPADDR21      = 'h3C5,
  PMPADDR22      = 'h3C6,
  PMPADDR23      = 'h3C7,
  PMPADDR24      = 'h3C8,
  PMPADDR25      = 'h3C9,
  PMPADDR26      = 'h3CA,
  PMPADDR27      = 'h3CB,
  PMPADDR28      = 'h3CC,
  PMPADDR29      = 'h3CD,
  PMPADDR30      = 'h3CE,
  PMPADDR31      = 'h3CF,
  PMPADDR32      = 'h3D0,
  PMPADDR33      = 'h3D1,
  PMPADDR34      = 'h3D2,
  PMPADDR35      = 'h3D3,
  PMPADDR36      = 'h3D4,
  PMPADDR37      = 'h3D5,
  PMPADDR38      = 'h3D6,
  PMPADDR39      = 'h3D7,
  PMPADDR40      = 'h3D8,
  PMPADDR41      = 'h3D9,
  PMPADDR42      = 'h3DA,
  PMPADDR43      = 'h3DB,
  PMPADDR44      = 'h3DC,
  PMPADDR45      = 'h3DD,
  PMPADDR46      = 'h3DE,
  PMPADDR47      = 'h3DF,
  PMPADDR48      = 'h3E0,
  PMPADDR49      = 'h3E1,
  PMPADDR50      = 'h3E2,
  PMPADDR51      = 'h3E3,
  PMPADDR52      = 'h3E4,
  PMPADDR53      = 'h3E5,
  PMPADDR54      = 'h3E6,
  PMPADDR55      = 'h3E7,
  PMPADDR56      = 'h3E8,
  PMPADDR57      = 'h3E9,
  PMPADDR58      = 'h3EA,
  PMPADDR59      = 'h3EB,
  PMPADDR60      = 'h3EC,
  PMPADDR61      = 'h3ED,
  PMPADDR62      = 'h3EE,
  PMPADDR63      = 'h3EF,
  MCYCLE         = 'hB00,
  MINSTRET       = 'hB02,
  MHPMCOUNTER3   = 'hB03,
  MHPMCOUNTER4   = 'hB04,
  MHPMCOUNTER5   = 'hB05,
  MHPMCOUNTER6   = 'hB06,
  MHPMCOUNTER7   = 'hB07,
  MHPMCOUNTER8   = 'hB08,
  MHPMCOUNTER9   = 'hB09,
  MHPMCOUNTER10  = 'hB0A,
  MHPMCOUNTER11  = 'hB0B,
  MHPMCOUNTER12  = 'hB0C,
  MHPMCOUNTER13  = 'hB0D,
  MHPMCOUNTER14  = 'hB0E,
  MHPMCOUNTER15  = 'hB0F,
  MHPMCOUNTER16  = 'hB10,
  MHPMCOUNTER17  = 'hB11,
  MHPMCOUNTER18  = 'hB12,
  MHPMCOUNTER19  = 'hB13,
  MHPMCOUNTER20  = 'hB14,
  MHPMCOUNTER21  = 'hB15,
  MHPMCOUNTER22  = 'hB16,
  MHPMCOUNTER23  = 'hB17,
  MHPMCOUNTER24  = 'hB18,
  MHPMCOUNTER25  = 'hB19,
  MHPMCOUNTER26  = 'hB1A,
  MHPMCOUNTER27  = 'hB1B,
  MHPMCOUNTER28  = 'hB1C,
  MHPMCOUNTER29  = 'hB1D,
  MHPMCOUNTER30  = 'hB1E,
  MHPMCOUNTER31  = 'hB1F,
  MCYCLEH        = 'hB80,
  MINSTRETH      = 'hB82,
  MHPMCOUNTER3H  = 'hB83,
  MHPMCOUNTER4H  = 'hB84,
  MHPMCOUNTER5H  = 'hB85,
  MHPMCOUNTER6H  = 'hB86,
  MHPMCOUNTER7H  = 'hB87,
  MHPMCOUNTER8H  = 'hB88,
  MHPMCOUNTER9H  = 'hB89,
  MHPMCOUNTER10H = 'hB8A,
  MHPMCOUNTER11H = 'hB8B,
  MHPMCOUNTER12H = 'hB8C,
  MHPMCOUNTER13H = 'hB8D,
  MHPMCOUNTER14H = 'hB8E,
  MHPMCOUNTER15H = 'hB8F,
  MHPMCOUNTER16H = 'hB90,
  MHPMCOUNTER17H = 'hB91,
  MHPMCOUNTER18H = 'hB92,
  MHPMCOUNTER19H = 'hB93,
  MHPMCOUNTER20H = 'hB94,
  MHPMCOUNTER21H = 'hB95,
  MHPMCOUNTER22H = 'hB96,
  MHPMCOUNTER23H = 'hB97,
  MHPMCOUNTER24H = 'hB98,
  MHPMCOUNTER25H = 'hB99,
  MHPMCOUNTER26H = 'hB9A,
  MHPMCOUNTER27H = 'hB9B,
  MHPMCOUNTER28H = 'hB9C,
  MHPMCOUNTER29H = 'hB9D,
  MHPMCOUNTER30H = 'hB9E,
  MHPMCOUNTER31H = 'hB9F,
  MCOUNTINHIBIT  = 'h320,
  MHPMEVENT3     = 'h323,
  MHPMEVENT4     = 'h324,
  MHPMEVENT5     = 'h325,
  MHPMEVENT6     = 'h326,
  MHPMEVENT7     = 'h327,
  MHPMEVENT8     = 'h328,
  MHPMEVENT9     = 'h329,
  MHPMEVENT10    = 'h32A,
  MHPMEVENT11    = 'h32B,
  MHPMEVENT12    = 'h32C,
  MHPMEVENT13    = 'h32D,
  MHPMEVENT14    = 'h32E,
  MHPMEVENT15    = 'h32F,
  MHPMEVENT16    = 'h330,
  MHPMEVENT17    = 'h331,
  MHPMEVENT18    = 'h332,
  MHPMEVENT19    = 'h333,
  MHPMEVENT20    = 'h334,
  MHPMEVENT21    = 'h335,
  MHPMEVENT22    = 'h336,
  MHPMEVENT23    = 'h337,
  MHPMEVENT24    = 'h338,
  MHPMEVENT25    = 'h339,
  MHPMEVENT26    = 'h33A,
  MHPMEVENT27    = 'h33B,
  MHPMEVENT28    = 'h33C,
  MHPMEVENT29    = 'h33D,
  MHPMEVENT30    = 'h33E,
  MHPMEVENT31    = 'h33F,
  MSECCFG        = 'h747,
  MSECCFGH       = 'h757,
  TSELECT        = 'h7A0,
  TDATA1         = 'h7A1,
  TDATA2         = 'h7A2,
  TDATA3         = 'h7A3,
  TINFO          = 'h7A4,
  TCONTROL       = 'h7A5,
  MCONTEXT       = 'h7A8,
  SCONTEXT       = 'h7AA,
  DCSR           = 'h7B0,
  DPC            = 'h7B1,
  DSCRATCH0      = 'h7B2,
  DSCRATCH1      = 'h7B3,
  VSTART         = 'h008,
  VXSTAT         = 'h009,
  VXRM           = 'h00A,
  VL             = 'hC20,
  VTYPE          = 'hC21,
  VLENB          = 'hC22,
  MCONFIGPTR     = 'hF15
} instr_csr_t;

bit [12-1:0] csr_name2addr[string] = '{
  "ustatus"        : USTATUS,
  "uie"            : UIE,
  "utvec"          : UTVEC,
  "uscratch"       : USCRATCH,
  "uepc"           : UEPC,
  "ucause"         : UCAUSE,
  "utval"          : UTVAL,
  "uip"            : UIP,
  "fflags"         : FFLAGS,
  "frm"            : FRM,
  "fcsr"           : FCSR,
  "cycle"          : CYCLE,
  "time"           : TIME,
  "instret"        : INSTRET,
  "hpmcounter3"    : HPMCOUNTER3,
  "hpmcounter4"    : HPMCOUNTER4,
  "hpmcounter5"    : HPMCOUNTER5,
  "hpmcounter6"    : HPMCOUNTER6,
  "hpmcounter7"    : HPMCOUNTER7,
  "hpmcounter8"    : HPMCOUNTER8,
  "hpmcounter9"    : HPMCOUNTER9,
  "hpmcounter10"   : HPMCOUNTER10,
  "hpmcounter11"   : HPMCOUNTER11,
  "hpmcounter12"   : HPMCOUNTER12,
  "hpmcounter13"   : HPMCOUNTER13,
  "hpmcounter14"   : HPMCOUNTER14,
  "hpmcounter15"   : HPMCOUNTER15,
  "hpmcounter16"   : HPMCOUNTER16,
  "hpmcounter17"   : HPMCOUNTER17,
  "hpmcounter18"   : HPMCOUNTER18,
  "hpmcounter19"   : HPMCOUNTER19,
  "hpmcounter20"   : HPMCOUNTER20,
  "hpmcounter21"   : HPMCOUNTER21,
  "hpmcounter22"   : HPMCOUNTER22,
  "hpmcounter23"   : HPMCOUNTER23,
  "hpmcounter24"   : HPMCOUNTER24,
  "hpmcounter25"   : HPMCOUNTER25,
  "hpmcounter26"   : HPMCOUNTER26,
  "hpmcounter27"   : HPMCOUNTER27,
  "hpmcounter28"   : HPMCOUNTER28,
  "hpmcounter29"   : HPMCOUNTER29,
  "hpmcounter30"   : HPMCOUNTER30,
  "hpmcounter31"   : HPMCOUNTER31,
  "cycleh"         : CYCLEH,
  "timeh"          : TIMEH,
  "instreth"       : INSTRETH,
  "hpmcounter3h"   : HPMCOUNTER3H,
  "hpmcounter4h"   : HPMCOUNTER4H,
  "hpmcounter5h"   : HPMCOUNTER5H,
  "hpmcounter6h"   : HPMCOUNTER6H,
  "hpmcounter7h"   : HPMCOUNTER7H,
  "hpmcounter8h"   : HPMCOUNTER8H,
  "hpmcounter9h"   : HPMCOUNTER9H,
  "hpmcounter10h"  : HPMCOUNTER10H,
  "hpmcounter11h"  : HPMCOUNTER11H,
  "hpmcounter12h"  : HPMCOUNTER12H,
  "hpmcounter13h"  : HPMCOUNTER13H,
  "hpmcounter14h"  : HPMCOUNTER14H,
  "hpmcounter15h"  : HPMCOUNTER15H,
  "hpmcounter16h"  : HPMCOUNTER16H,
  "hpmcounter17h"  : HPMCOUNTER17H,
  "hpmcounter18h"  : HPMCOUNTER18H,
  "hpmcounter19h"  : HPMCOUNTER19H,
  "hpmcounter20h"  : HPMCOUNTER20H,
  "hpmcounter21h"  : HPMCOUNTER21H,
  "hpmcounter22h"  : HPMCOUNTER22H,
  "hpmcounter23h"  : HPMCOUNTER23H,
  "hpmcounter24h"  : HPMCOUNTER24H,
  "hpmcounter25h"  : HPMCOUNTER25H,
  "hpmcounter26h"  : HPMCOUNTER26H,
  "hpmcounter27h"  : HPMCOUNTER27H,
  "hpmcounter28h"  : HPMCOUNTER28H,
  "hpmcounter29h"  : HPMCOUNTER29H,
  "hpmcounter30h"  : HPMCOUNTER30H,
  "hpmcounter31h"  : HPMCOUNTER31H,
  "sstatus"        : SSTATUS,
  "sedeleg"        : SEDELEG,
  "sideleg"        : SIDELEG,
  "sie"            : SIE,
  "stvec"          : STVEC,
  "scounteren"     : SCOUNTEREN,
  "sscratch"       : SSCRATCH,
  "sepc"           : SEPC,
  "scause"         : SCAUSE,
  "stval"          : STVAL,
  "sip"            : SIP,
  "satp"           : SATP,
  "mvendorid"      : MVENDORID,
  "marchid"        : MARCHID,
  "mimpid"         : MIMPID,
  "mhartid"        : MHARTID,
  "mstatus"        : MSTATUS,
  "misa"           : MISA,
  "medeleg"        : MEDELEG,
  "mideleg"        : MIDELEG,
  "mie"            : MIE,
  "mtvec"          : MTVEC,
  "mcounteren"     : MCOUNTEREN,
  "menvcfg"        : MENVCFG,
  "mstatush"       : MSTATUSH,
  "menvcfgh"       : MENVCFGH,
  "mscratch"       : MSCRATCH,
  "mepc"           : MEPC,
  "mcause"         : MCAUSE,
  "mtval"          : MTVAL,
  "mip"            : MIP,
  "pmpcfg0"        : PMPCFG0,
  "pmpcfg1"        : PMPCFG1,
  "pmpcfg2"        : PMPCFG2,
  "pmpcfg3"        : PMPCFG3,
  "pmpcfg4"        : PMPCFG4,
  "pmpcfg5"        : PMPCFG5,
  "pmpcfg6"        : PMPCFG6,
  "pmpcfg7"        : PMPCFG7,
  "pmpcfg8"        : PMPCFG8,
  "pmpcfg9"        : PMPCFG9,
  "pmpcfg10"       : PMPCFG10,
  "pmpcfg11"       : PMPCFG11,
  "pmpcfg12"       : PMPCFG12,
  "pmpcfg13"       : PMPCFG13,
  "pmpcfg14"       : PMPCFG14,
  "pmpcfg15"       : PMPCFG15,
  "pmpaddr0"       : PMPADDR0,
  "pmpaddr1"       : PMPADDR1,
  "pmpaddr2"       : PMPADDR2,
  "pmpaddr3"       : PMPADDR3,
  "pmpaddr4"       : PMPADDR4,
  "pmpaddr5"       : PMPADDR5,
  "pmpaddr6"       : PMPADDR6,
  "pmpaddr7"       : PMPADDR7,
  "pmpaddr8"       : PMPADDR8,
  "pmpaddr9"       : PMPADDR9,
  "pmpaddr10"      : PMPADDR10,
  "pmpaddr11"      : PMPADDR11,
  "pmpaddr12"      : PMPADDR12,
  "pmpaddr13"      : PMPADDR13,
  "pmpaddr14"      : PMPADDR14,
  "pmpaddr15"      : PMPADDR15,
  "pmpaddr16"      : PMPADDR16,
  "pmpaddr17"      : PMPADDR17,
  "pmpaddr18"      : PMPADDR18,
  "pmpaddr19"      : PMPADDR19,
  "pmpaddr20"      : PMPADDR20,
  "pmpaddr21"      : PMPADDR21,
  "pmpaddr22"      : PMPADDR22,
  "pmpaddr23"      : PMPADDR23,
  "pmpaddr24"      : PMPADDR24,
  "pmpaddr25"      : PMPADDR25,
  "pmpaddr26"      : PMPADDR26,
  "pmpaddr27"      : PMPADDR27,
  "pmpaddr28"      : PMPADDR28,
  "pmpaddr29"      : PMPADDR29,
  "pmpaddr30"      : PMPADDR30,
  "pmpaddr31"      : PMPADDR31,
  "pmpaddr32"      : PMPADDR32,
  "pmpaddr33"      : PMPADDR33,
  "pmpaddr34"      : PMPADDR34,
  "pmpaddr35"      : PMPADDR35,
  "pmpaddr36"      : PMPADDR36,
  "pmpaddr37"      : PMPADDR37,
  "pmpaddr38"      : PMPADDR38,
  "pmpaddr39"      : PMPADDR39,
  "pmpaddr40"      : PMPADDR40,
  "pmpaddr41"      : PMPADDR41,
  "pmpaddr42"      : PMPADDR42,
  "pmpaddr43"      : PMPADDR43,
  "pmpaddr44"      : PMPADDR44,
  "pmpaddr45"      : PMPADDR45,
  "pmpaddr46"      : PMPADDR46,
  "pmpaddr47"      : PMPADDR47,
  "pmpaddr48"      : PMPADDR48,
  "pmpaddr49"      : PMPADDR49,
  "pmpaddr50"      : PMPADDR50,
  "pmpaddr51"      : PMPADDR51,
  "pmpaddr52"      : PMPADDR52,
  "pmpaddr53"      : PMPADDR53,
  "pmpaddr54"      : PMPADDR54,
  "pmpaddr55"      : PMPADDR55,
  "pmpaddr56"      : PMPADDR56,
  "pmpaddr57"      : PMPADDR57,
  "pmpaddr58"      : PMPADDR58,
  "pmpaddr59"      : PMPADDR59,
  "pmpaddr60"      : PMPADDR60,
  "pmpaddr61"      : PMPADDR61,
  "pmpaddr62"      : PMPADDR62,
  "pmpaddr63"      : PMPADDR63,
  "mcycle"         : MCYCLE,
  "minstret"       : MINSTRET,
  "mhpmcounter3"   : MHPMCOUNTER3,
  "mhpmcounter4"   : MHPMCOUNTER4,
  "mhpmcounter5"   : MHPMCOUNTER5,
  "mhpmcounter6"   : MHPMCOUNTER6,
  "mhpmcounter7"   : MHPMCOUNTER7,
  "mhpmcounter8"   : MHPMCOUNTER8,
  "mhpmcounter9"   : MHPMCOUNTER9,
  "mhpmcounter10"  : MHPMCOUNTER10,
  "mhpmcounter11"  : MHPMCOUNTER11,
  "mhpmcounter12"  : MHPMCOUNTER12,
  "mhpmcounter13"  : MHPMCOUNTER13,
  "mhpmcounter14"  : MHPMCOUNTER14,
  "mhpmcounter15"  : MHPMCOUNTER15,
  "mhpmcounter16"  : MHPMCOUNTER16,
  "mhpmcounter17"  : MHPMCOUNTER17,
  "mhpmcounter18"  : MHPMCOUNTER18,
  "mhpmcounter19"  : MHPMCOUNTER19,
  "mhpmcounter20"  : MHPMCOUNTER20,
  "mhpmcounter21"  : MHPMCOUNTER21,
  "mhpmcounter22"  : MHPMCOUNTER22,
  "mhpmcounter23"  : MHPMCOUNTER23,
  "mhpmcounter24"  : MHPMCOUNTER24,
  "mhpmcounter25"  : MHPMCOUNTER25,
  "mhpmcounter26"  : MHPMCOUNTER26,
  "mhpmcounter27"  : MHPMCOUNTER27,
  "mhpmcounter28"  : MHPMCOUNTER28,
  "mhpmcounter29"  : MHPMCOUNTER29,
  "mhpmcounter30"  : MHPMCOUNTER30,
  "mhpmcounter31"  : MHPMCOUNTER31,
  "mcycleh"        : MCYCLEH,
  "minstreth"      : MINSTRETH,
  "mhpmcounter3h"  : MHPMCOUNTER3H,
  "mhpmcounter4h"  : MHPMCOUNTER4H,
  "mhpmcounter5h"  : MHPMCOUNTER5H,
  "mhpmcounter6h"  : MHPMCOUNTER6H,
  "mhpmcounter7h"  : MHPMCOUNTER7H,
  "mhpmcounter8h"  : MHPMCOUNTER8H,
  "mhpmcounter9h"  : MHPMCOUNTER9H,
  "mhpmcounter10h" : MHPMCOUNTER10H,
  "mhpmcounter11h" : MHPMCOUNTER11H,
  "mhpmcounter12h" : MHPMCOUNTER12H,
  "mhpmcounter13h" : MHPMCOUNTER13H,
  "mhpmcounter14h" : MHPMCOUNTER14H,
  "mhpmcounter15h" : MHPMCOUNTER15H,
  "mhpmcounter16h" : MHPMCOUNTER16H,
  "mhpmcounter17h" : MHPMCOUNTER17H,
  "mhpmcounter18h" : MHPMCOUNTER18H,
  "mhpmcounter19h" : MHPMCOUNTER19H,
  "mhpmcounter20h" : MHPMCOUNTER20H,
  "mhpmcounter21h" : MHPMCOUNTER21H,
  "mhpmcounter22h" : MHPMCOUNTER22H,
  "mhpmcounter23h" : MHPMCOUNTER23H,
  "mhpmcounter24h" : MHPMCOUNTER24H,
  "mhpmcounter25h" : MHPMCOUNTER25H,
  "mhpmcounter26h" : MHPMCOUNTER26H,
  "mhpmcounter27h" : MHPMCOUNTER27H,
  "mhpmcounter28h" : MHPMCOUNTER28H,
  "mhpmcounter29h" : MHPMCOUNTER29H,
  "mhpmcounter30h" : MHPMCOUNTER30H,
  "mhpmcounter31h" : MHPMCOUNTER31H,
  "mcountinhibit"  : MCOUNTINHIBIT,
  "mhpmevent3"     : MHPMEVENT3,
  "mhpmevent4"     : MHPMEVENT4,
  "mhpmevent5"     : MHPMEVENT5,
  "mhpmevent6"     : MHPMEVENT6,
  "mhpmevent7"     : MHPMEVENT7,
  "mhpmevent8"     : MHPMEVENT8,
  "mhpmevent9"     : MHPMEVENT9,
  "mhpmevent10"    : MHPMEVENT10,
  "mhpmevent11"    : MHPMEVENT11,
  "mhpmevent12"    : MHPMEVENT12,
  "mhpmevent13"    : MHPMEVENT13,
  "mhpmevent14"    : MHPMEVENT14,
  "mhpmevent15"    : MHPMEVENT15,
  "mhpmevent16"    : MHPMEVENT16,
  "mhpmevent17"    : MHPMEVENT17,
  "mhpmevent18"    : MHPMEVENT18,
  "mhpmevent19"    : MHPMEVENT19,
  "mhpmevent20"    : MHPMEVENT20,
  "mhpmevent21"    : MHPMEVENT21,
  "mhpmevent22"    : MHPMEVENT22,
  "mhpmevent23"    : MHPMEVENT23,
  "mhpmevent24"    : MHPMEVENT24,
  "mhpmevent25"    : MHPMEVENT25,
  "mhpmevent26"    : MHPMEVENT26,
  "mhpmevent27"    : MHPMEVENT27,
  "mhpmevent28"    : MHPMEVENT28,
  "mhpmevent29"    : MHPMEVENT29,
  "mhpmevent30"    : MHPMEVENT30,
  "mhpmevent31"    : MHPMEVENT31,
  "mseccfg"        : MSECCFG,
  "mseccfgh"       : MSECCFGH,
  "tselect"        : TSELECT,
  "tdata1"         : TDATA1,
  "tdata2"         : TDATA2,
  "tdata3"         : TDATA3,
  "tinfo"          : TINFO,
  "tcontrol"       : TCONTROL,
  "mcontext"       : MCONTEXT,
  "scontext"       : SCONTEXT,
  "dcsr"           : DCSR,
  "dpc"            : DPC,
  "dscratch0"      : DSCRATCH0,
  "dscratch1"      : DSCRATCH1,
  "vstart"         : VSTART,
  "vxstat"         : VXSTAT,
  "vxrm"           : VXRM,
  "vl"             : VL,
  "vtype"          : VTYPE,
  "vlenb"          : VLENB,
  "mconfigptr"     : MCONFIGPTR
};

typedef enum bit[2:0] {
  CAUSE_RSVD0        = 3'h0,
  CAUSE_EBREAK       = 3'h1,
  CAUSE_TRIGGER      = 3'h2,
  CAUSE_HALTREQ      = 3'h3,
  CAUSE_STEP         = 3'h4,
  CAUSE_RESETHALTREQ = 3'h5,
  CAUSE_RSVD6        = 3'h6,
  CAUSE_RSVD7        = 3'h7
} dcsr_cause_t;

typedef enum {
  BITMANIP_VERSION_0P90,
  BITMANIP_VERSION_0P91,
  BITMANIP_VERSION_0P92,
  BITMANIP_VERSION_0P93,
  BITMANIP_VERSION_0P93_DRAFT,
  BITMANIP_VERSION_0P94,
  BITMANIP_VERSION_1P00
} bitmanip_version_t;

typedef enum {
  PRIV_VERSION_1_11,
  PRIV_VERSION_1_10,
  PRIV_VERSION_20190405,
  PRIV_VERSION_MASTER
} priv_spec_version_t;

typedef enum {
  ENDIAN_LITTLE,
  ENDIAN_BIG,
  ENDIAN_MIXED
} endianness_t;


typedef struct packed {
    // Major mode enable controls
   bit                          enabled;
   bit                          is_active;
   bit                          scoreboarding_enabled;
   bit                          disable_all_csr_checks;
   //bit [CSR_MASK_WL-1:0]        disable_csr_check_mask;
   bit [10:0]        disable_csr_check_mask;
   bit                          cov_model_enabled;
   bit                          trn_log_enabled;

   // ISS configuration
   bit                          use_iss;

   // RISC-V ISA Configuration
   corev_mxl_t                  xlen;
   int unsigned                 ilen;

   bit                          ext_i_supported;
   bit                          ext_a_supported;
   bit                          ext_m_supported;
   bit                          ext_c_supported;
   bit                          ext_p_supported;
   bit                          ext_v_supported;
   bit                          ext_f_supported;
   bit                          ext_d_supported;
   bit                          ext_zba_supported;
   bit                          ext_zbb_supported;
   bit                          ext_zbc_supported;
   bit                          ext_zbe_supported;
   bit                          ext_zbf_supported;
   bit                          ext_zbm_supported;
   bit                          ext_zbp_supported;
   bit                          ext_zbr_supported;
   bit                          ext_zbs_supported;
   bit                          ext_zbt_supported;
   bit                          ext_zcb_supported;
   bit                          ext_zifencei_supported;
   bit                          ext_zicsr_supported;
   bit                          ext_zicntr_supported;

   bit                          ext_cv32a60x_supported;

   bit                          mode_s_supported;
   bit                          mode_u_supported;

   bit                          pmp_supported;
   int unsigned                 pmp_regions;
   bit                          debug_supported;

   bitmanip_version_t           bitmanip_version;

   priv_spec_version_t          priv_spec_version;

   endianness_t                 endianness;

   bit                          unaligned_access_supported;
   bit                          unaligned_access_amo_supported;

   // Mask of CSR addresses that are not supported in this core
   // post_randomize() will adjust this based on extension and mode support
   bit [11-1:0]        unsupported_csr_mask;

   // Common parameters
   int unsigned                 num_mhpmcounters;
   //uvma_core_cntrl_pma_region_c  pma_regions[];

   // Common bootstrap addresses
   // The valid bits should be constrained if the bootstrap signal is not valid for this core configuration
   bit [128-1:0]           mhartid;
   bit                          mhartid_valid;
   bit                          mhartid_plusarg_valid;

   bit [128-1:0]           mvendorid;
   bit                          mvendorid_valid;
   bit                          mvendorid_plusarg_valid;

   bit [128-1:0]           mimpid;
   bit                          mimpid_plusarg_valid;

   bit [128-1:0]           boot_addr;
   bit                          boot_addr_valid;
   bit                          boot_addr_plusarg_valid;

   bit [128-1:0]           mtvec_addr;
   bit                          mtvec_addr_valid;
   bit                          mtvec_addr_plusarg_valid;

   bit [128-1:0]           dm_halt_addr;
   bit                          dm_halt_addr_valid;
   bit                          dm_halt_addr_plusarg_valid;

   bit [128-1:0]           dm_exception_addr;
   bit                          dm_exception_addr_valid;
   bit                          dm_exception_addr_plusarg_valid;

   bit [128-1:0]           nmi_addr;
   bit                          nmi_addr_valid;
   bit                          nmi_addr_plusarg_valid;

} st_core_cntrl_cfg;

`endif // __UVMA_CORE_CNTRL_TDEFS_SV__



