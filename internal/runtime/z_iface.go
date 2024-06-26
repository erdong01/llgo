/*
 * Copyright (c) 2024 The GoPlus Authors (goplus.org). All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package runtime

import (
	"unsafe"

	"github.com/goplus/llgo/internal/abi"
)

type Interface = iface

type InterfaceType = abi.InterfaceType

var (
	TyAny = &InterfaceType{}
)

func MakeAnyInt(typ *Type, data uintptr) Interface {
	return Interface{
		tab:  &itab{inter: TyAny, _type: typ, hash: 0, fun: [1]uintptr{0}},
		data: unsafe.Pointer(data),
	}
}

func MakeAnyString(data string) Interface {
	return Interface{
		tab:  &itab{inter: TyAny, _type: Basic(abi.String), hash: 0, fun: [1]uintptr{0}},
		data: unsafe.Pointer(&data),
	}
}

func MakeAny(typ *Type, data unsafe.Pointer) Interface {
	return Interface{
		tab:  &itab{inter: TyAny, _type: typ, hash: 0, fun: [1]uintptr{0}},
		data: data,
	}
}

func MakeInterface(inter *InterfaceType, typ *Type, data unsafe.Pointer) Interface {
	return Interface{
		tab:  &itab{inter: inter, _type: typ, hash: 0, fun: [1]uintptr{0}},
		data: data,
	}
}

func I2Int(v Interface, t *Type) uintptr {
	if v.tab._type == t {
		return uintptr(v.data)
	}
	panic("I2Int: type mismatch")
}

func CheckI2Int(v Interface, t *Type) (uintptr, bool) {
	if v.tab._type == t {
		return uintptr(v.data), true
	}
	return 0, false
}
