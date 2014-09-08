//+------------------------------------------------------------------+
//|                                                     royalola.mq4 |
//|                           Copyright 2014, Royalxm he fuck all EA |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, Royalxm he fuck all EA"
#property version   "1.00"
#property strict

double tabpriceup[4];
double tabpricedown[4];
double moyenne;
double limitebuy=0.00010;
int boolbuy=0;

double distancebuy;   
int boolt=0;
int i= 0;

string timeupload;
int ticket;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   timeupload = TimeToStr(Time[0]);
   tabpriceup[0] = iHigh(NULL,PERIOD_M5,2);
   tabpriceup[1] = iHigh(NULL,PERIOD_M5,1);
   i = 2;
   boolt=0;
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   
   Print(" i : ",i," timeu :", timeupload);
   double vbid = MarketInfo(Symbol(),MODE_BID);
   double vask = MarketInfo(Symbol(),MODE_ASK);
     
   Print("Symbol=",Symbol());
   Print("Last incoming bid price="+ vbid);
   Print("Last incoming ask price=",vask);
 Print("1= ",tabpriceup[0]);
  Print("2= ", tabpriceup[1]);


   if(StringCompare(timeupload,TimeToStr(Time[0])) != 0)
   {
      tabpriceup[i] = iHigh(NULL,PERIOD_M5,1);
      if(i != 4)
      {
         i = i + 1;
      }
      printf("NEW UPLOAD :");
      timeupload = TimeToStr(Time[0]);
      if( i == 4)
      {
         //decalage des valeur et remettre le i a 3
         
         tabpriceup[0] = tabpriceup[1];
         tabpriceup[1] = tabpriceup[2];
         tabpriceup[2] = tabpriceup[3];
         i = 3;
         boolt = 0;
      }

   }
   
   if(i == 3 && boolt == 0)
   {
      ObjectDelete("Moyenne");
   ObjectDelete("buy");
   limitebuy=0.00030;
     moyenne = tabpriceup[0] + tabpriceup[1];
     moyenne = moyenne + tabpriceup[2];
     moyenne = moyenne /3;
     printf("Moyenne:  " + moyenne);

   ObjectCreate("Moyenne", OBJ_HLINE, 0, Time[0], moyenne, 0, 0);
   limitebuy = limitebuy + moyenne;
    ObjectSet("Moyenne", OBJPROP_COLOR,Red );
    ObjectCreate("buy", OBJ_HLINE, 0, Time[0], limitebuy, 0, 0);
     ObjectSet("buy", OBJPROP_COLOR,Lime );
     
      boolt = 1;
   }
   
   
   if(limitebuy <= vbid && boolt == 1 )
   {
    double price=Ask;
    OrderSend(NULL,OP_BUY,1,price,3,Ask - 400 * Point,Ask + 40 * Point,"ROYAL",16384,0,clrGreen);
      boolt == 0;
   }
   if(OrderSelect(2,SELECT_BY_POS,MODE_HISTORY)==true)
    {
     datetime ctm=OrderOpenTime();
     if(ctm>0)
     {
      Print("Open time for the order 10 ", ctm);
      }
     ctm=OrderCloseTime();
     if(ctm>0)
     {
      Print("Close time for the order 10 ", ctm);
      }
    }
   
  }
//+------------------------------------------------------------------+
