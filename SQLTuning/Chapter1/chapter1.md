# 1장. SQL 처리과정과 I/O
## 1.1 SQL 파싱과 최적화
### 1.1.1 구조적, 집합적, 선언적 질의 언어
SQL은 Structured Query Language의 줄임말이다. 말 그대로 구조적 질의 언어이다.

원하는 결과 집합을 구조적, 집합적으로 선언하지만, 그 결과 집합을 만드는 과정은 절차적일 수밖에 없다. 즉, 프로시저가 필요한데, 그런 프로시저를 만들어 내는 DBMS 내부 엔진이 바로 SQL 옵티마이저이다.
### SQL 최적화
SQL을 실행하기 전 최적화 과정을 세분화하면 아래와 같다.
1. SQL 파싱
  - 파싱 트리 생성
  - Syntax 체크: 문법적(규칙) 오류가 없는지 확인
  - Semantic 체크: 의미상 오류가 없는지 확인
2. SQL 최적화
  - 옵티마이저가 SQL 최적화를 담당한다. SQL 옵티마이저는 미리 수집한 시스템 및 오브젝트 통계정보(cost base)를 바탕으로 다양한 실행경로를 생성해서 비교한 후 가장 효율적인 하나를 선택한다.

### 옵티마이저 힌트
수동으로 제어하는 것이다.
#### 주의사항 
1. 힌트 안에 인자를 나열할 땐','(콤마)를 사용할 수 있지만, 힌트와 힌트 사이에 사용하면 안 된다.
2. 테이블을 지정할 때 스키마명까지 명시하면 안 된다.
3. FROM절 테이블명 옆에 ALIAS를 지정했다면, 힌트에도 반드시 ALIAS를 사용해야 한다.

## 1.2 SQL 공유 및 재사용
### 소프트 파싱 vs. 하드 파싱
- 라이브러리 캐시(Library Cache): SQL 파싱, 최적화, 로우 소스 생성 과정을 거쳐 생성한 내부 프로시저를 반복 재사용할 수 있도록 캐싱해 두는 메모리 공간
- SGA(System Global Area): 서버 프로세스와 백그라운드 프로세스가 공통으로 액세스하는 데이터와 제어 구조를 캐싱하는 메모리 공간이다.
- SQL 실행 과정<br>
사용자가 SQL 문을 전달하면 DBMS는 SQL을 파싱한 후 해당 SQL이 라이브러리 캐시에 존재하는지부터 확인한다. 
  - 소프트 파싱(Soft Parsing): SQL을 캐시에서 찾아 곧바로 실행단계로 넘어가는 것
  - 하드 파싱(Hard Parsing): SQL을 캐시에서 찾지 못해 최적화 및 로우 소스 생성 단계까지 모두 거치는 것을 하드 파싱(Hard Parsing)이라고 한다.

### 바인드 변수의 중요성
사용자 정의 함수/프로시저, 트리거, 패키지 등은 생성할 때부터 이름을 갖는다. 한편 SQL은 이름이 따로 없다. 전체 텍스트가 이름 역할을 한다. 이로 인해 텍스트 중 작은 부분이라도 수정되면 그 순간 다른 객체가 새로 탄생하는 구조이다.
```sql
SELECT * FROM CUSTOMER WHERE LOGIN_ID = '" + login_id + "';
SELECT * FROM CUSTOMER WHERE LOGIN_ID = ?
```
아래의 문장은 아이디가 달라도 같은 쿼리로 인식된다. ⇒ 추상화
아래와 같은 문장을 prepared statement라고 한다. 
이를 통해 캐시를 제어할 수 있게 되어 성능이 향상된다. 또한 SQL 캐시를 효율적으로 다루며, 보안이 향상된다.

## 1.3 데이터 저장 구조 및 I/O 메커니즘