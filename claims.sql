-- SSFN key is unique.
-- Find claims that are paid and are core
SELECT
attribution_permission
,COUNT(*) as paid_claims
FROM claim.v_claim
WHERE adjudication_date::date > date('2021-09-02')
AND product = 'core'
AND is_paid_claim = 1
GROUP BY 1

-- find # of claims by parent pharmacy that we could attribute.
SELECT 
parent_pharmacy_name,
count(*) 
FROM claim.v_claim 
WHERE product = 'core' 
AND common_id IS NOT NULL 
AND attribution_permission = 'phi_allowed'
group by 1
order by 2 desc;


-- find claims where coupon viewer's account PII differs from the claimer's
SELECT * 
FROM claim.v_claim 
WHERE product = 'core' 
AND common_id IS NOT NULL 
AND attribution_permission = 'phi_not_allowed' 
LIMIT 5

-- join on tables v_claim_transaction
