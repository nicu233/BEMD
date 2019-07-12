function wkl=wkl(k,l,s,t)
%0<=k,l<=3
%计算第(k,l)个双三次B样条基函数在s,t的值，0<=s,t<=1
%s0='(1-s)^3/6';
%s1='(3*s^3-6*s^2+4)/6';
%s2='(-3*s^3+3*s^2+3*s+1)/6';
%s3='s^3/6';
switch k
  case 0 
    bk=(1-s)^3/6;
    switch l
      case 0
        wkl=bk*(1-t)^3/6;
      case 1
        wkl=bk*(3*t^3-6*t^2+4)/6;
      case 2
        wkl=bk*(-3*t^3+3*t^2+3*t+1)/6;
      case 3
        wkl=bk*t^3/6;
      end
  case 1
      bk=(3*s^3-6*s^2+4)/6;
      switch l
        case 0
          wkl=bk*(1-t)^3/6;
        case 1
          wkl=bk*(3*t^3-6*t^2+4)/6;
        case 2
          wkl=bk*(-3*t^3+3*t^2+3*t+1)/6;
        case 3
          wkl=bk*t^3/6;
        end
  case 2
       bk=(-3*s^3+3*s^2+3*s+1)/6;
       switch l
        case 0
          wkl=bk*(1-t)^3/6;
        case 1
          wkl=bk*(3*t^3-6*t^2+4)/6;
        case 2
          wkl=bk*(-3*t^3+3*t^2+3*t+1)/6;
        case 3
          wkl=bk*t^3/6;
        end
    case 3
       bk=s^3/6;
       switch l
        case 0
          wkl=bk*(1-t)^3/6;
        case 1
          wkl=bk*(3*t^3-6*t^2+4)/6;
        case 2
          wkl=bk*(-3*t^3+3*t^2+3*t+1)/6;
        case 3
          wkl=bk*t^3/6;
        end
    otherwise
        error('You input is error');
    end