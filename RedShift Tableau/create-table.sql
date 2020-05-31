CREATE TABLE public.dim_carriers (
	"carrier code" character(2) NOT NULL,
	"carrier name" character varying(100)  NOT NULL,
PRIMARY KEY("carrier code")
)
DISTSTYLE ALL;

CREATE TABLE public.dim_airports (
	"airport code" character(3)  NOT NULL,
	"airport name" character varying(50)  NOT NULL,
	city character varying(50) NULL,
	state character varying(2) NULL,
	country character varying(3) NOT NULL,
	latitude numeric(9,6)  NOT NULL,
	longitude numeric(9,6) NOT NULL,
 PRIMARY KEY ("airport code")
)
DISTSTYLE ALL;

CREATE TABLE public.fact_flights (
	"flight date" timestamp without time zone NOT NULL,
	"carrier code" character(2)  NOT NULL,
	"flight code" numeric(4,0)  NOT NULL,
	"tail number" character varying (6)  NOT NULL,
	"origin airport code" character(3)  NOT NULL,
	"destination airport code" character(3)  NOT NULL,
	"flight distance" numeric(4,0)  NOT NULL,
	"flight airtime" numeric(4,0)  NOT NULL,
	"scheduled departure time" numeric(4,0)  NOT NULL,
	"scheduled arrival time" numeric(4,0)  NOT NULL,
	"scheduled elasped time" numeric(4,0)  NOT NULL,
	"estimated departure time" numeric(4,0)  NULL,
	"estimated arrival time" numeric(4,0)  NULL,
	"estimated elapsed time" numeric(4,0)  NULL,
	"cancelled flag" character(1)  NOT NULL DEFAULT 'N',
	"diverted flag" character(1)  NOT NULL DEFAULT 'N',
	"aircraft delay" numeric(4,0)  NOT NULL DEFAULT 0,
	"airtraffic delay" numeric(4,0)  NOT NULL DEFAULT 0,
	"security delay" numeric(4,0) NOT  NULL DEFAULT 0,
	"weather delay" numeric(4,0)  NOT NULL DEFAULT 0,
 foreign key("origin airport code") references "dim_airports"("airport code"),
 foreign key("destination airport code") references "dim_airports"("airport code"),
 foreign key("carrier code") references "dim_carriers"("carrier code")
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY ("flight date","origin airport code", "destination airport code");