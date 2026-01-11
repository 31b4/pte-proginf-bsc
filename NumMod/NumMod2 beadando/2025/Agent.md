# Agent Instructions - Numerikus Módszerek (Numerical Methods) Repository

## Repository Overview
This repository contains MATLAB solutions for numerical methods problems, organized in folders 1-8 (easy to hard difficulty). Each folder contains problem solutions with comprehensive Hungarian comments for code defense purposes.

## Language Requirements
- **Code**: English (function names, variables)
- **Comments**: Hungarian (mandatory - for oral defense with professor)
- **Problem descriptions**: Hungarian
- **Comments must be exhaustive** - explain every step, algorithm, mathematical concept, and logic

## Problem Specifications

**CRITICAL**: Each folder contains a PDF file with the official problem description:
- **Naming convention**: `num2gyak2025_{folder_number}.pdf`
- **Examples**: 
  - Folder 1 → `num2gyak2025_1.pdf`
  - Folder 2 → `num2gyak2025_2.pdf`
  - Folder 3 → `num2gyak2025_3.pdf`

**Before solving any problem, you MUST**:
1. Read the PDF in the folder to understand the exact requirements
2. Verify that your solution matches the problem specification
3. Ensure test cases cover all scenarios described in the PDF
4. Check that output format matches what the PDF requests

The PDFs are in Hungarian and contain:
- Mathematical formulas and definitions
- Input/output specifications
- Edge cases to handle
- Expected behavior and constraints

## Agent Workflow Instructions

### When Working on This Repository:

1. **Always Read the Problem PDF First**
   - Locate `num2gyak2025_{folder_number}.pdf` in the target folder
   - Understand all requirements before implementing
   - Verify existing solutions match the PDF specifications

2. **Always Run Tests After Reading PDF**
   ```matlab
   cd 1 && matlab -batch "run('test_all.m')"
   cd 2 && matlab -batch "run('test_gauss.m')"
   ```

3. **Code Review Checklist**:
   - ✅ PDF problem specification read and understood
   - ✅ Solution matches PDF requirements exactly
   - ✅ All comments in Hungarian
   - ✅ Comments explain every algorithm step
   - ✅ Mathematical concepts documented
   - ✅ Edge cases handled with clear errors
   - ✅ Input validation present
   - ✅ Variable names are descriptive
   - ✅ Test cases verify correctness against PDF

4. **Comment Requirements**:
   Every function must have:
   - **Header comment**: Purpose, usage, parameters, return values
   - **Step-by-step comments**: What each code block does
   - **Mathematical explanation**: Formulas and reasoning
   - **Edge case handling**: Why errors are thrown
   
   Example:
   ```matlab
   function x = fl1(v)
   % fl1: gépi szám vektorból valós számot számol
   % Bemenet: v = [előjel_bit, mantissza_bitek..., karakterisztika]
   % Kimenet: x = a valós szám értéke
   % 
   % A gépi számrendszerben egy számot a következőképpen ábrázolunk:
   % x = (-1)^s * m * 2^k
   % ahol s az előjelbit, m a mantissza, k a karakterisztika
   
   m = v(1:end-1); % mantissza vektor kinyerése (tartalmazza az előjelbitet is)
   k = v(end);     % karakterisztika (kitevő) kinyerése
   s = (-1)^m(1);  % előjel számítása: ha m(1)=0 akkor +1, ha m(1)=1 akkor -1
   
   % Mantissza törtrész számítása
   % A mantissza bitek 2^-1, 2^-2, 2^-3, ... súllyal szerepelnek
   frac = 0;
   for i = 2:length(m)
       if m(i) ~= 0 && m(i) ~= 1
           error('Mantissza hibás (nem 0/1 bit).');
       end
       frac = frac + m(i)*2^(-(i-1)); % i-edik bit hozzáadása
   end
   
   % Végső valós szám kiszámítása: előjel * mantissza * 2^karakterisztika
   x = s * frac * 2^k;
   end
   ```

5. **Testing Protocol**:
   - Run test files after any modification
   - Verify outputs match expected results
   - Check edge cases (zero pivots, overflow, underflow)
   - Test with various input parameters
   - Compare results with examples in the PDF

6. **Error Handling**:
   - All invalid inputs must throw descriptive errors in Hungarian
   - Examples:
     - `error('A mátrix nem négyzetes.');`
     - `error('Nulla pivot - szükséges lenne sor/oszlopcsere!');`
     - `error('Mantissza hibás (nem 0/1 bit).');`

## Code Defense Strategy

The repository is designed for oral defense with a professor. Students must be able to:

1. **Explain every line**: Comments provide the explanation
2. **Justify design choices**: Why certain algorithms are used
3. **Demonstrate understanding**: Mathematical concepts explained in comments
4. **Handle questions**: Comprehensive comments cover all "why" questions

## Adding New Problems (Folders 3-8)

When adding new problem folders:

1. **Read the PDF first**: Open `num2gyak2025_{folder_number}.pdf` and understand all requirements
2. **Create folder structure**: `mkdir {folder_number} && cd {folder_number}`
3. **Implement solutions** based on PDF specifications with Hungarian comments
4. **Create test file**: `test_*.m` to verify correctness against PDF examples
5. **Update this Agent.md** with problem descriptions
6. **Run tests** to ensure everything works as specified in the PDF
7. **Cross-reference**: Verify all edge cases and examples from PDF are tested

## Common MATLAB Patterns Used

### Input Validation:
```matlab
if ~isscalar(t) || t<=0 || floor(t)~=t
    error('t hibás - pozitív egész szám kell');
end
```

### Matrix Operations:
```matlab
[L,U,P] = lu(A);      % LU felbontás
detA = det(A);        % Determináns
Ainv = inv(A);        % Inverz mátrix
```

### Bit Operations:
```matlab
bitget(m_bits, t-1:-1:1)  % Bitek kinyerése számból
```

### Optional Parameters:
```matlab
if nargin < 3
    showSteps = false;  % Alapértelmezett érték
end
```

## Quality Standards

- ✅ **100% Hungarian comments** for defense
- ✅ **Comprehensive explanations** for every algorithm
- ✅ **Test coverage** for all functions
- ✅ **Error handling** for invalid inputs
- ✅ **Consistent style** across all files
- ✅ **Mathematical rigor** in implementations

## Notes for Future Development

- Folders 3-8 will contain more advanced topics:
  - Interpolation (interpoláció)
  - Numerical integration (numerikus integrálás)
  - Differential equations (differenciálegyenletek)
  - Eigenvalue problems (sajátérték problémák)
  - Optimization (optimalizálás)
  - Root finding (gyökkereső módszerek)

## Quick Reference

**Run all tests:**
```bash
cd 1 && matlab -batch "run('test_all.m')"
cd 2 && matlab -batch "run('test_gauss.m')"
```

**Check specific function:**
```matlab
help fl1
help gaussel2
```

**Test single function:**
```matlab
x = fl1([0 1 0 1 2])  % Should return 2.5
```
