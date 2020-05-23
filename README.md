# League of legend Match Analysis

## Request Library 
- minim (import ddf.minim.*;)  # for audio sound


## Instruction
- Run sketch_601114a.pde
- Fill SummonerName (in-game name) OR MatchID (You can get form replay filename or Game client -> match history -> copy between slash ("/");

`ex https://matchhistory.th.leagueoflegends.com/th/#match-details/TH/169196324/144857395?tab=overview`

we get
...s/TH/{__**169196324**__}/14485...


and last weg got
__169196324__

\w/\w/\w/\w/\w/\w/\w/

- Next, when filled then we pressed "ENTER" for inserted serching data

- Confirm your Input
- Last, waiting a little 
- when finished we should got analized data  i.e. Gold Earnned in match,
 player build (item), KDA (Kill/ Dead /Assist), and map line (position die in map)


## Benefit
You can get new view more than your enermy and you can analize your playe style


## has bug!?
getupdate form my github : 
`https://github.com/kandation/leagueVirtual`

---------------------------

# โปรแกรมวิเคราะห์คู่การแข่งขันในเกม league of legend
## ต้องการ
- ไลบรารี่เสียงของ minim (import ddf.minim.*;) # ที่จริงก็ // ปิดไปก็ได้นะ
- Internet (ต้องทำการโหลดไฟล์ทุกครั้ง แต่ถ้าเน็ตไม่มี ก็ไม่ต้องกังวัล เพราะ โปรแกรมโหลดทุกอย่างมาเก็บไว้แล้ว สามารถใช้เลข MatchID เดิมเปิดได้เลย)
 
## วิธีใช้
- เปิด sketch_601114a.pde
- กรอก ชื่อซัมมอนเนอร์ (ชื่อในเกม) ของใครก็ได้ (หรือไม่มีอยู่จริงก็ได้)  หรือ ถ้ามี replay ไฟล์เก่าๆ ก็สามารถ
 เอาตัวเลขในชื่อไฟล์นั้น มาใส่ได้ (เช่น TH-__169031564__.rofl) หรือ ถ้าเปิด ประวัติการแข่งแล้วรู้สึกหงุดหงิดกับข้อมูล
ที่เปรียบเทียบยาก ก็สามารถเอาเลขตรงกลาง จากลิงก์นั้น มาใส่ได้
เช่น 

`https://matchhistory.th.leagueoflegends.com/th/#match-details/TH/169196324/144857395?tab=overview`

**สังเกตตรง**
...s/TH/{__169196324___}/14485...

นี่มันเลขวิเศษ เราก็เอามันมากรอกใส่ได้เลย
__169196324__

\w/\w/\w/\w/\w/\w/\w/

พอเลือกได้ว่าอยากใส่ชื่อ หรือ เลขแมชแข่ง ไปแล้ว ก็กด `"ENTER"` เพื่อดำเนินการต่อไป

ถ้าอยากจะแก้ ก็กด `ปุ่มแดงๆ` ไปแก้ละ


- รอ มันโหลดข้อมูลภาพจากเชริฟเวอร์สักแปป (ขั้นตอนนี้ ถ้าเน็ตหลุด มันจะเตะออก ต้องเริ่มทำใหม่ตั้งแต่ต้น T_T)

- เสร็จแล้วมันจะแสดงหน้า moive พาเข้าสู้ หน้าวิเคราะห์ผล

- ในหน้านี้ เรามารสามารถ ดูจำนวน ทอง (เครื่องบงว่า คุณเก็บเงิน ลาส ครีบ ได้เก่งแค่ไหน)  , คู่ต่อสู้ของคุณออกของยังไง
 (ไอเท็มมีผลต่อดาเมจ หรือ พลังในการรักษา ถ้าคุณเป็นซัพพอทของทีมอะนะ) , หรือ   KDA (คะแนนการฆ่า ตาย และช่วยเหลือ) ซึ่งผมส่งผลต่อเงินของคุณ และ สเต๊กดาเมจ
และ timeline ที่เกิดขึ้นบนแผนที่


และนั้นแหละคือประโยชน์ที่คุณได้รับ
แต่ข้อมูลเหล่านั้น มีประโยชน์มากกว่านั้นอีก ถ้าเอาไปวิเคราะห์ เช่น รอบนี้คุณรู้สึกเล่นแย่ๆ แต่ชนะมาได้ ตัวละคร ไอเท็มช่วยเหลือ ไอเท็ม ดาเมจ หรือ กระสุนน้อยๆของ มินเนี่ยน
อาจจะทำให้ผลการแข่ง และสไตลการเล่นคุณและคนรอบข้าง ... ลองสังเกตแล้วเอาไปปรับเป็นไตลคุณเองในแมชต่อไป

------------------

# Preview

[preview](Docs/Screenshot.jpg)

