# Lab1_DL

# 🧩 Generadores de Analizadores Léxicos con Flex

## 📌 Descripción del Proyecto

Este proyecto corresponde al **Problema 2 (50%) – Actividades de Experimentación con Flex**.

El objetivo es diseñar e implementar un **analizador léxico (lexer)** utilizando **Flex**, aplicando los conceptos teóricos de generación automática de analizadores léxicos a partir de expresiones regulares.

Se desarrollaron múltiples extensiones progresivas del lexer, incluyendo reconocimiento de identificadores, literales numéricos, operadores, comentarios y cadenas con secuencias de escape.

Además, se incluye:

* 📂 Código fuente del lexer (.l)
* 🧪 Casos de prueba
* 🎥 Video explicativo
* 📖 Documentación de cada inciso solicitado

---

# 📚 Marco Teórico

Un **generador de analizadores léxicos** es una herramienta que automatiza la construcción de lexers a partir de especificaciones declarativas.

En lugar de programar manualmente cada token, el desarrollador define patrones utilizando **expresiones regulares (regex)**, y la herramienta genera automáticamente el código del analizador.

### 🔁 Proceso Interno de Generación

1. Construcción de un **NFA (Autómata Finito No Determinista)**.
2. Conversión a **DFA (Determinista)** mediante construcción de subconjuntos.
3. Minimización del DFA.
4. Generación de código optimizado que implementa el autómata.

### ⚙️ Características modernas de generadores léxicos

* Resolución de ambigüedades por precedencia
* Acciones semánticas
* Estados léxicos
* Manejo de errores
* Soporte para múltiples lenguajes

---

# 🛠️ Herramientas Utilizadas

* **Flex**
* GCC
* Linux / WSL / Ubuntu
* Git & GitHub

---

# 📌 Incisos Desarrollados

## 1️⃣ Reconocimiento de Identificadores en Java

Se implementó una regla que reconoce identificadores válidos en Java:

* Comienzan con letra o `_`
* Seguidos por letras, dígitos o `_`

Ejemplos válidos:

```
variable
_variable
contador1
```

Ejemplos inválidos:

```
1variable
@nombre
```

---

## 2️⃣ Literales Numéricos

Se clasifican los siguientes tipos:

* 🔢 Enteros
* 🔣 Flotantes
* 🔬 Notación científica
* 🧮 Hexadecimales

El lexer imprime:

```
TOKEN: ENTERO      VALOR: 123
TOKEN: FLOAT       VALOR: 3.14
TOKEN: CIENTIFICO  VALOR: 1.2e10
TOKEN: HEXADECIMAL VALOR: 0xFF
```

---

## 3️⃣ Operadores Reconocidos

### Aritméticos

```
+  -  *  /
```

### Relacionales

```
==  !=  <  >  <=  >=
```

### Lógicos

```
&&  ||  !
```

---

## 4️⃣ Comentarios

Soporte para:

* Comentarios de una línea: `//`
* Comentarios multilínea: `/* ... */`

Los comentarios:

✔ Son reconocidos
❌ No generan tokens

---

## 5️⃣ Cadenas Literales

Reconocimiento de strings entre comillas dobles:

```
"Hola mundo"
"Linea\nNueva"
"Tab\tEspacio"
```

Secuencias de escape soportadas:

* `\n`
* `\t`
* `\"`
* `\\`

---

## 6️⃣ Pruebas en Otro Lenguaje

Se realizaron pruebas utilizando código en **C**, demostrando que el lexer funciona correctamente fuera de Java y Python.

---

## 7️⃣ Cambio de Color de Palabras (Estilo VS Code)

Para implementar resaltado de sintaxis sería necesario:

1. Asociar cada token con una categoría.
2. Generar salida en:

   * HTML con estilos CSS, o
   * ANSI escape codes en terminal.
3. Opcionalmente, desarrollar una extensión de editor.

El lexer ya clasifica tokens, lo que facilita esta implementación.

---

## 8️⃣ Herramienta Similar a Flex

### 🟣 ANTLR

ANTLR es una herramienta moderna para generar analizadores léxicos y sintácticos.

Características:

* Genera lexer y parser.
* Soporta múltiples lenguajes.
* Utiliza gramáticas formales.
* Produce árboles sintácticos (AST).

A diferencia de Flex, ANTLR integra análisis léxico y sintáctico en un solo sistema.

---

# 🚀 Cómo Compilar y Ejecutar

```bash
flex lexer.l
gcc lex.yy.c -o lexer -lfl
./lexer archivo_prueba.txt
```

---

# 📂 Estructura del Repositorio

```
/lexer.l
/tests/
README.md
/video_explicacion.mp4
```

---

# 🎥 Video Explicativo

El repositorio incluye un video donde se explica:

* Cada inciso desarrollado
* Ejemplos ejecutándose
* Explicación del funcionamiento interno
* Demostración de compilación

---

# 🎯 Conclusiones

Este proyecto demuestra cómo:

* Las expresiones regulares se transforman en autómatas.
* Flex automatiza la generación de analizadores léxicos.
* Es posible extender progresivamente un lexer.
* La teoría de autómatas tiene aplicación directa en compiladores.

Se reforzaron conceptos de:

* NFA y DFA
* Minimización de autómatas
* Tokens y patrones
* Generación automática de código




Solo dime cuál prefieres 🔥

