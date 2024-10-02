# Advanced calculator in Bash

This is a simple command-line based advanced calculator script written in Bash. It supports basic arithmetic operations, maintains a history of calculations, and allows the use of the previous answer in subsequent calculations.

## Features

- **Basic Arithmetic Operations**: Addition, subtraction, multiplication, division, and modulus.
- **History Management**: Keeps a history of the last 5 calculations.
- **ANS Variable**: Use the result of the previous calculation in new calculations.
- **Clear Terminal**: Clears the terminal screen.

## Usage
### Basic Operations

Here are some examples of how to use the basic arithmetic operations:

- **Addition**: `5 + 3`
- **Subtraction**: `10 - 4`
- **Multiplication**: `7 * 6`
- **Division**: `8 / 2`
- **Modulus**: `9 % 4`

### Examples

```bash
# Addition
./advanced-calculator.sh 
>> 5 + 3
8

# Subtraction
./advanced-calculator.sh 
>> 10 - 4
6

# Multiplication
./advanced-calculator.sh 
>> 7 * 6
42

# Division
./advanced-calculator.sh 
>> 8 / 2
4

# Modulus
./advanced-calculator.sh 
>> 9 % 4
1
```

### Running the Script

To run the script, use the following command in your terminal:

```bash
./advanced-calculator.sh
```

## Files
- **advanced-calculator.sh**: The main script file.
- **ans_value.txt**: Stores the result of the last calculation.
- **calc_history.txt**: Stores the history of the last 5 calculations.